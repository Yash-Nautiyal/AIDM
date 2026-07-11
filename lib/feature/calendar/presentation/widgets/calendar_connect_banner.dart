import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarConnectBanner extends StatelessWidget {
  const CalendarConnectBanner({
    super.key,
    required this.onConnectTap,
    required this.onDismiss,
  });

  final VoidCallback onConnectTap;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingVerticalMd,
      ),
      decoration: BoxDecoration(
        color: theme.backgroundInput,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20.sp,
            height: 20.sp,
            decoration: BoxDecoration(
              color: theme.brandPrimary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'i',
                style: typography.captionBold.copyWith(
                  color: theme.brandPrimaryTint,
                  fontSize: 12.sp,
                  height: 1,
                ),
              ),
            ),
          ),
          SizedBox(width: AppDimensions.spacingSm),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: typography.captionLight.copyWith(
                  color: theme.textSecondary,
                  height: 1.4,
                ),
                children: [
                  const TextSpan(
                    text:
                        'Connect your Google or Outlook calendar to sync webinars automatically. ',
                  ),
                  TextSpan(
                    text: 'Connect now ›',
                    style: typography.captionBold.copyWith(
                      color: theme.brandPrimary,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onConnectTap,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: AppDimensions.spacingXs),
          GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.opaque,
            child: SvgPicture.asset(
              AppAssets.closeIcon,
              width: AppDimensions.iconSizeSm,
              height: AppDimensions.iconSizeSm,
              colorFilter: ColorFilter.mode(
                theme.textTertiary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
