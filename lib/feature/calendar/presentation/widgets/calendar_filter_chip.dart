import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

class CalendarFilterChip extends StatelessWidget {
  const CalendarFilterChip({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    final borderColor = isActive ? theme.brandPrimary : theme.borderDefault;
    final textColor = isActive ? theme.brandPrimary : theme.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: 16.sp,
            vertical: 8.sp,
          ),
          decoration: BoxDecoration(
            color: theme.backgroundPage,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: typography.bodyMedium.copyWith(color: textColor),
              ),
              SizedBox(width: AppDimensions.spacingXs),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18.sp,
                color: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
