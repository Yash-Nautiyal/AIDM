import 'package:flutter/material.dart';

import '../widgets/auth_page_layout.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      title: "Let's Get You\nSigned Up!",
      buttonLabel: 'Request OTP',
      secondaryPrefix: 'Already have an account? ',
      secondaryActionLabel: 'Login',
      onPrimaryPressed: (_) {
        // TODO: Request OTP flow
      },
      onSecondaryPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInPage()),
        );
      },
    );
  }
}
