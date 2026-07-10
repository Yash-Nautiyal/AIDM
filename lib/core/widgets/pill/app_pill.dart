import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

class AppPill extends StatelessWidget {
  const AppPill({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 10.sp),
          decoration: BoxDecoration(
            color: isSelected ? theme.brandPrimary : theme.backgroundPage,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
            border: isSelected ? null : Border.all(color: theme.borderDefault),
          ),
          child: Text(
            label,
            style: typography.bodyMedium.copyWith(
              color: isSelected ? theme.brandPrimaryTint : theme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
