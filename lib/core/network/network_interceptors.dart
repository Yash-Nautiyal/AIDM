import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

import '../utils/app/app_logger.dart';
import 'network_client.dart';
import 'network_config.dart';
import 'session_cookie_store.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.network('→ ${options.method} ${options.uri}');
    if (options.data != null) {
      AppLogger.network('  body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> r, ResponseInterceptorHandler h) {
    AppLogger.network('← ${r.statusCode} ${r.requestOptions.uri}');
    AppLogger.network('  data: ${r.data}');
    h.next(r);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler h) {
    AppLogger.network(
      '✗ ${err.requestOptions.method} ${err.requestOptions.uri} '
      'status=${err.response?.statusCode} message=${err.message}',
    );
    h.next(err);
  }
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required UnauthorizedCallback onUnauthorized})
    : _onUnauthorized = onUnauthorized;

  final UnauthorizedCallback _onUnauthorized;
  bool _handling = false;

  @override
  void onResponse(Response<dynamic> r, ResponseInterceptorHandler h) {
    if (r.statusCode == 401) _fire();
    h.next(r);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler h) {
    if (err.response?.statusCode == 401) _fire();
    h.next(err);
  }

  void _fire() {
    if (_handling) return;
    _handling = true;
    AppLogger.session('401 received → signing out');
    _onUnauthorized();
    _handling = false;
  }
}

class SessionCookieInterceptor extends Interceptor {
  SessionCookieInterceptor({
    required SessionCookieStore cookieStore,
    required CookieJar cookieJar,
  }) : _store = cookieStore,
       _jar = cookieJar;

  final SessionCookieStore _store;
  final CookieJar _jar;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final id = _store.sessionId;
    if (id != null && id.isNotEmpty) {
      AppLogger.cookie(
        'Injecting ${ApiConstants.sessionCookieName} on ${options.path}',
      );
      final pair = '${ApiConstants.sessionCookieName}=$id';
      final existing = options.headers['Cookie'];
      if (existing is String && existing.isNotEmpty) {
        if (!existing.contains(ApiConstants.sessionCookieName)) {
          options.headers['Cookie'] = '$existing; $pair';
        }
      } else {
        options.headers['Cookie'] = pair;
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> r, ResponseInterceptorHandler h) {
    _capture(r).then((_) => h.next(r));
  }

  Future<void> _capture(Response<dynamic> response) async {
    final fromHeader = _fromSetCookie(response.headers);
    if (fromHeader != null) {
      AppLogger.cookie(
        'Captured ${ApiConstants.sessionCookieName} from Set-Cookie header',
      );
      await _store.save(fromHeader);
      return;
    }
    final cookies = await _jar.loadForRequest(response.requestOptions.uri);
    for (final c in cookies) {
      if (c.name == ApiConstants.sessionCookieName && c.value.isNotEmpty) {
        AppLogger.cookie(
          'Captured ${ApiConstants.sessionCookieName} from cookie jar',
        );
        await _store.save(c.value);
        return;
      }
    }
    AppLogger.cookie('No ${ApiConstants.sessionCookieName} in response');
  }

  String? _fromSetCookie(Headers headers) {
    for (final e in headers.map.entries) {
      if (e.key.toLowerCase() != 'set-cookie') continue;
      for (final raw in e.value) {
        final m = RegExp(
          '${RegExp.escape(ApiConstants.sessionCookieName)}=([^;]+)',
        ).firstMatch(raw);
        if (m != null) return Uri.decodeComponent(m.group(1)!);
      }
    }
    return null;
  }
}
