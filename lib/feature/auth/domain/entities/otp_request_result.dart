class OtpRequestResult {
  const OtpRequestResult({
    required this.email,
    required this.isNewUser,
  });

  final String email;
  final bool isNewUser;
}
