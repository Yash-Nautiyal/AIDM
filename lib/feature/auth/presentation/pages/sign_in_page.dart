import 'package:flutter/material.dart';

import '../widgets/auth_page_layout.dart';
import 'otp_verification_page.dart';
import 'sign_up_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
      title: 'Welcome\nBack!',
      buttonLabel: 'Login',
      secondaryPrefix: "Don't have an account? ",
      secondaryActionLabel: 'Sign Up',
      onPrimaryPressed: (email) => _navigateToOtp(context, email),
      onSecondaryPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignUpPage()),
        );
      },
    );
  }
}
