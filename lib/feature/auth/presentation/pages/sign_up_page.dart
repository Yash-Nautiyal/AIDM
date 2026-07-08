import 'package:flutter/material.dart';

import '../widgets/auth_page_layout.dart';
import 'otp_verification_page.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  void _navigateToOtp(BuildContext context, String email) {
    if (email.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationPage(email: email),
      ),
    );
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInPage()),
        );
      },
    );
  }
}
