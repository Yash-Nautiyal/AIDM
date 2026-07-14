import 'package:aidm/core/utils/auth/auth_utils.dart';

import '../../domain/entities/verify_otp_result.dart';

class VerifyOtpResponseModel {
  const VerifyOtpResponseModel({
    required this.email,
    required this.isNewUser,
    required this.isPremium,
    this.displayName,
    this.avatarUrl,
  });

  final String email;
  final bool isNewUser;
  final bool isPremium;
  final String? displayName;
  final String? avatarUrl;

  factory VerifyOtpResponseModel.fromJson(
    Map<String, dynamic> json, {
    required String email,
  }) {
    final user = readUserMap(json);

    final resolvedEmail =
        readString(user, const ['email']) ??
        readString(json, const ['email']) ??
        email;

    final isPremium =
        readBool(user, const [
          'isPremium',
          'is_premium',
          'hasPremium',
          'isSubscribed',
        ]) ||
        readBool(json, const [
          'isPremium',
          'is_premium',
          'hasPremium',
          'isSubscribed',
        ]);

    return VerifyOtpResponseModel(
      email: resolvedEmail,
      isNewUser: readBool(json, const ['isNewUser', 'is_new_user', 'newUser']),
      isPremium: isPremium,
      displayName: readDisplayName(json),
      avatarUrl:
          readString(user, const ['avatar', 'avatarUrl', 'avatar_url']) ??
          readString(json, const ['avatar', 'avatarUrl', 'avatar_url']),
    );
  }

  VerifyOtpResult toEntity() {
    return VerifyOtpResult(
      email: email,
      isNewUser: isNewUser,
      isPremium: isPremium,
      displayName: displayName,
      avatarUrl: avatarUrl,
    );
  }
}
