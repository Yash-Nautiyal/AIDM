import 'package:dio/dio.dart';

import '../../result/app_failure.dart';

class NetworkUtils {
  NetworkUtils._();
  
  static AppFailure mapDioException(DioException exception) {
    final statusCode = exception.response?.statusCode;
    if (statusCode == 401) return const UnauthorizedFailure();

    final message = extractMessage(exception.response?.data);
    if (statusCode != null && statusCode >= 400 && statusCode < 500) {
      return ValidationFailure(
        message: message ?? 'Request could not be completed.',
      );
    }

    return switch (exception.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.connectionError => const NetworkFailure(),
      _ => ServerFailure(message: message ?? exception.message),
    };
  }

  static String? extractMessage(Object? data) {
    if (data is String && data.isNotEmpty) return data;
    if (data is Map<String, dynamic>) {
      final message = data['message'] ?? data['error'];
      if (message is String && message.isNotEmpty) return message;
    }
    return null;
  }
}
