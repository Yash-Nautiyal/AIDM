import 'package:flutter/material.dart';

import '../../../../../core/constant/app_dimensions.dart';
import '../../../../../core/theme/app_theme_extension.dart';
import '../../../../../core/theme/typography/app_typography_extension.dart';

class HomeWebinarListEmpty extends StatelessWidget {
  const HomeWebinarListEmpty({
    super.key,
    required this.title,
    required this.subtitle,
    required this.theme,
    required this.typography,
  });

  final String title;
  final String subtitle;
  final AppThemeExtension theme;
  final AppTypographyExtension typography;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: typography.h3.copyWith(color: theme.textPrimary),
          textAlign: TextAlign.center,
        ),
        if (subtitle.trim().isNotEmpty) ...[
          SizedBox(height: AppDimensions.spacingSm),
          Text(
            subtitle,
            style: typography.bodyMedium.copyWith(color: theme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
