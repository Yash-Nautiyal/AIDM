import 'package:flutter/material.dart';

import '../../../../../../core/constant/app_dimensions.dart';
import '../../../../../../core/theme/app_theme_extension.dart';
import '../../../../../../core/theme/typography/app_typography_extension.dart';

class StartSheetPrivacy extends StatelessWidget {
  const StartSheetPrivacy({
    super.key,
    required this.label,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    final backgroundColor = isSelected
        ? theme.brandPrimary
        : theme.backgroundPage;
    final borderColor = isSelected
        ? theme.brandPrimary
        : theme.buttonTertiaryBorder;
    final titleColor = isSelected ? theme.brandPrimaryTint : theme.textPrimary;
    final subtitleColor = isSelected
        ? theme.brandPrimaryTint.withValues(alpha: 0.85)
        : theme.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingLg,
            vertical: AppDimensions.spacingVerticalMd,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: typography.bodySemibold.copyWith(color: titleColor),
              ),
              SizedBox(height: AppDimensions.spacingVerticalXs),
              Text(
                subtitle,
                style: typography.captionLight.copyWith(color: subtitleColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
