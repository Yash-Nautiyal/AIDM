import 'package:aidm/core/routes/app_router.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_page_layout.dart';
import 'otp_verification_page.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  void _navigateToOtp(BuildContext context, String email) {
    if (email.isEmpty) return;

    moveTo(context, OtpVerificationPage(email: email));
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      title: "Let's Get You\nSigned Up!",
      buttonLabel: 'Request OTP',
      secondaryPrefix: 'Already have an account? ',
      secondaryActionLabel: 'Login',
      onPrimaryPressed: (email) => _navigateToOtp(context, email),
      onSecondaryPressed: () {
        moveTo(context, const SignInPage(), replace: true);
      },
    );
  }
}
