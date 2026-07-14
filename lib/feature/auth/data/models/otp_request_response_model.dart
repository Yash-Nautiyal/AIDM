import 'package:aidm/core/utils/auth/auth_utils.dart';

import '../../domain/entities/otp_request_result.dart';

class OtpRequestResponseModel {
  const OtpRequestResponseModel({required this.email, required this.isNewUser});

  final String email;
  final bool isNewUser;

  factory OtpRequestResponseModel.fromJson(
    Map<String, dynamic> json, {
    required String email,
  }) {
    return OtpRequestResponseModel(
      email: email,
      isNewUser: readBool(json, const ['isNewUser', 'is_new_user', 'newUser']),
    );
  }

  OtpRequestResult toEntity() {
    return OtpRequestResult(email: email, isNewUser: isNewUser);
  }
}
