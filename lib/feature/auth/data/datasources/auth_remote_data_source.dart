import 'dart:convert';

import 'package:aidm/core/network/network_config.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/network_client.dart';
import '../../../../core/utils/app/app_logger.dart';
import '../models/otp_request_response_model.dart';
import '../models/verify_otp_response_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<OtpRequestResponseModel> requestOtp(String email) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.requestOtp,
      data: {'email': email},
    );

    final data = response.data ?? const {};
    ensureApiSuccess(data);

    return OtpRequestResponseModel.fromJson(data, email: email);
  }

  Future<VerifyOtpResponseModel> verifyOtp({
    required String email,
    required int otp,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.verifyOtp,
      data: {'email': email, 'otp': otp},
    );

    final data = response.data ?? const {};
    ensureApiSuccess(data);

    AppLogger.auth(
      'verifyOtp full response:\n'
      '${const JsonEncoder.withIndent('  ').convert(data)}',
    );

    return VerifyOtpResponseModel.fromJson(data, email: email);
  }

  Future<OtpRequestResponseModel> resendOtp(String email) => requestOtp(email);

  Future<void> createAccount({
    required String email,
    required int otp,
    required String firstName,
    required String lastName,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.createAccount,
      data: {
        'email': email,
        'otp': otp,
        'firstName': firstName,
        'lastName': lastName,
        'trackingParams': <String, dynamic>{},
      },
    );

    ensureApiSuccess(response.data);
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    final response = await _dio.put<Map<String, dynamic>>(
      ApiEndpoints.updateProfile,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'otp': null,
      },
    );

    ensureApiSuccess(response.data);
  }

  Future<void> updateAvatar(String filePath) async {
    final fileName = filePath.split('/').last;

    final response = await _dio.put<Map<String, dynamic>>(
      ApiEndpoints.updateAvatar,
      data: FormData.fromMap({
        'avatar': await MultipartFile.fromFile(filePath, filename: fileName),
      }),
    );

    ensureApiSuccess(response.data);
  }
}
