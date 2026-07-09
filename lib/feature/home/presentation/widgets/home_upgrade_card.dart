import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/responsive_extension.dart';

class HomeUpgradeCard extends StatelessWidget {
  const HomeUpgradeCard({super.key, this.onUpgradeTap});

  final VoidCallback? onUpgradeTap;

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    final radius = BorderRadius.circular(AppDimensions.radiusXl);

    return ClipRRect(
      borderRadius: radius,
      child: SizedBox(
        height: 220.h,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SvgPicture.asset(
              AppAssets.cardPoster,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing2xl,
                vertical: AppDimensions.spacingVertical3xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(AppAssets.premiumImg, width: 18.sp),
                  SizedBox(height: AppDimensions.spacingXs),
                  Text(
                    'Upgrade to Pro',
                    style: typography.h4.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: AppDimensions.spacingXs),
                  Text(
                    'Unlock unlimited attendees, HD\nrecording, and priority support.',
                    style: typography.bodyCompact.copyWith(
                      color: Colors.white.withValues(alpha: 0.90),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppButton1(
                          height: AppDimensions.buttonHeightMd,
                          label: 'Upgrade Now',
                          type: AppButton1Type.secondary,
                          expand: false,
                          onPressed: onUpgradeTap,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
