enum AuthResumeRoute {
  welcome,
  signUp,
  signIn,
  otpVerification,
  permission,
  subscription,
}

extension AuthResumeRouteX on AuthResumeRoute {
  /// Pre-verify auth screens are not restored after a cold launch.
  bool get isPreAuthCheckpoint => switch (this) {
    AuthResumeRoute.signUp ||
    AuthResumeRoute.signIn ||
    AuthResumeRoute.otpVerification => true,
    _ => false,
  };
}
