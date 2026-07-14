class VerifyOtpResult {
  const VerifyOtpResult({
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
}
