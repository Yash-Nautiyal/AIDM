import 'package:flutter/material.dart';

import '../../../../../core/constant/app_dimensions.dart';
import '../../../../../core/theme/app_theme_extension.dart';
import '../../../../../core/theme/typography/app_typography_extension.dart';

class SubscriptionMenuRow extends StatelessWidget {
  const SubscriptionMenuRow({super.key, required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: AppDimensions.spacingVerticalLg),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: typography.bodyMedium.copyWith(color: theme.textPrimary),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: theme.textSecondary,
              size: AppDimensions.iconSizeLg,
            ),
          ],
        ),
      ),
    );
  }
}
