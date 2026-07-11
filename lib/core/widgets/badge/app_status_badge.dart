import 'dart:ui';

import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.label,
    this.showDot = true,
    this.blurSigma = 12,
    this.color,
  });

  final String label;
  final bool showDot;
  final double blurSigma;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final radius = BorderRadius.circular(AppDimensions.radiusXl);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
          decoration: BoxDecoration(
            color: color ?? theme.brandPrimaryTint.withValues(alpha: 0.18),
            borderRadius: radius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showDot) ...[
                Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    color: theme.brandPrimaryTint,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: AppDimensions.spacingXs),
              ],
              Text(
                label,
                style: typography.captionBold.copyWith(
                  color: theme.brandPrimaryTint,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
