import 'package:flutter/material.dart';

import '../widgets/auth_page_layout.dart';
import 'sign_up_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      title: 'Welcome\nBack!',
      buttonLabel: 'Login',
      secondaryPrefix: "Don't have an account? ",
      secondaryActionLabel: 'Sign Up',
      onPrimaryPressed: (_) {
        // TODO: Login flow
      },
      onSecondaryPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignUpPage()),
        );
      },
    );
  }
}
