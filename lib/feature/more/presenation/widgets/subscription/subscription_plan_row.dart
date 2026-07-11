import 'package:flutter/material.dart';

import '../../../../../core/constant/app_assets.dart';
import '../../../../../core/constant/app_dimensions.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_theme_extension.dart';
import '../../../../../core/theme/typography/app_typography_extension.dart';
import '../../../../../core/utils/responsive_extension.dart';
import '../../../../../core/widgets/badge/app_status_badge.dart';

class SubscriptionPlanRow extends StatelessWidget {
  const SubscriptionPlanRow({
    super.key,
    this.title = 'Premium Plan',
    this.subtitle,
    this.licenseLabel,
    this.licenseStatus,
    this.showBadge = false,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final String? licenseLabel;
  final String? licenseStatus;
  final Widget? trailing;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Padding(
      padding: EdgeInsets.only(
        top: AppDimensions.spacingVerticalLg,
        bottom: AppDimensions.spacingVerticalLg,
      ),
      child: Row(
        children: [
          Image.asset(AppAssets.premiumImg, width: 28.sp, height: 28.sp),
          SizedBox(width: AppDimensions.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: typography.labelLarge),
                SizedBox(height: 2.sp),
                if (licenseLabel != null) ...[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        licenseLabel!,
                        style: typography.captionLight.copyWith(
                          color: theme.textSecondary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: AppDimensions.spacingXs,
                          left: AppDimensions.spacingXs,
                        ),
                        child: CircleAvatar(
                          radius: 1.3.sp,
                          backgroundColor: theme.textSecondary,
                        ),
                      ),
                      if (licenseStatus != null)
                        Text(
                          licenseStatus!,
                          style: typography.captionLight.copyWith(
                            color: theme.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ],
                if (subtitle != null) ...[
                  Text(
                    subtitle!,
                    style: typography.captionLight.copyWith(
                      color: theme.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          trailing ?? const SizedBox.shrink(),
          if (showBadge)
            const AppStatusBadge(
              label: 'Active',
              color: AppColors.switchTrackActive,
              showDot: false,
              blurSigma: 0,
            ),
        ],
      ),
    );
  }
}
