import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

import '../result/app_failure.dart';
import '../utils/app/app_logger.dart';
import '../utils/network/network_utils.dart';
import 'network_config.dart';
import 'network_interceptors.dart';
import 'session_cookie_store.dart';

// MARK: Dio factory

typedef UnauthorizedCallback = void Function();

class NetworkBundle {
  const NetworkBundle({required this.dio, required this.cookieJar});

  final Dio dio;
  final CookieJar cookieJar;
}

class UnauthorizedNotifier {
  void Function()? onUnauthorized;
  void notify() => onUnauthorized?.call();
}

abstract final class NetworkClient {
  NetworkClient._();

  static Future<NetworkBundle> create({
    required SessionCookieStore cookieStore,
    required UnauthorizedCallback onUnauthorized,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final cookieJar = PersistCookieJar(
      storage: FileStorage('${dir.path}/.cookies/'),
      ignoreExpires: true,
    );

    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      LoggingInterceptor(),
      SessionCookieInterceptor(cookieStore: cookieStore, cookieJar: cookieJar),
      CookieManager(cookieJar),
      AuthInterceptor(onUnauthorized: onUnauthorized),
    ]);

    AppLogger.network('Dio client ready → ${ApiEndpoints.baseUrl}');

    return NetworkBundle(dio: dio, cookieJar: cookieJar);
  }
}

// MARK: Response / error helpers (used by data layer)

class ApiResponseException implements Exception {
  const ApiResponseException(this.message);
  final String message;
}

void ensureApiSuccess(Map<String, dynamic>? data) {
  if (data == null) return;
  final success = data['success'];
  if (success is bool && !success) {
    throw ApiResponseException(
      NetworkUtils.extractMessage(data) ?? 'Request could not be completed.',
    );
  }
}

AppFailure mapCaughtError(Object error) {
  if (error is ApiResponseException) {
    return ValidationFailure(message: error.message);
  }
  if (error is DioException) return NetworkUtils.mapDioException(error);
  return UnknownFailure(message: error.toString());
}

// MARK: Session cookie helpers (used by auth repository)

Future<bool> hasSessionCookie({
  required CookieJar cookieJar,
  SessionCookieStore? cookieStore,
}) async {
  if (cookieStore?.hasSession ?? false) return true;

  for (final uri in _cookieUris) {
    final cookies = await cookieJar.loadForRequest(uri);
    if (cookies.any(
      (c) => c.name == ApiConstants.sessionCookieName && c.value.isNotEmpty,
    )) {
      return true;
    }
  }
  return false;
}

Future<void> clearSessionCookies(CookieJar cookieJar) async {
  for (final uri in _cookieUris) {
    await cookieJar.delete(uri);
  }
}

final _cookieUris = [
  ApiConstants.apiUri,
  ApiConstants.originUri,
  Uri.parse('https://webinar-api.webinar.gg/'),
  Uri.parse('https://webinar.gg/'),
];
