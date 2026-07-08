import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthLegalFooter extends StatelessWidget {
  const AuthLegalFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final baseStyle = typography.captionLight.copyWith(
      color: theme.textPrimary,
    );
    final boldStyle = typography.captionBold.copyWith(
      color: theme.textPrimary,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: 'By proceeding, you agree to our '),
          TextSpan(
            text: 'Terms',
            style: boldStyle,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: boldStyle,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
