import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:aidm/core/widgets/card/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeWebinarCardData {
  const HomeWebinarCardData({
    required this.title,
    required this.teamAndLocation,
    required this.timeRange,
    required this.date,
    required this.statusLabel,
    required this.statusColor,
    required this.registeredLabel,
  });

  final String title;
  final String teamAndLocation;
  final String timeRange;
  final DateTime date;
  final String statusLabel;
  final Color statusColor;
  final String registeredLabel;
}

class HomeWebinarCard extends StatelessWidget {
  const HomeWebinarCard({super.key, required this.data, this.onTap});

  final HomeWebinarCardData data;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return InkWell(
      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      onTap: onTap,
      child: AppCard(
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          child: Stack(
            children: [
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.spacingLg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.title,
                                  style: typography.labelLarge.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: theme.textPrimary,
                                  ),
                                ),
                                SizedBox(
                                  height: AppDimensions.spacingVerticalXs,
                                ),
                                Text(
                                  data.teamAndLocation,
                                  style: typography.captionLight.copyWith(
                                    color: theme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: theme.brandPrimary,
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimensions.spacingVerticalMd),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 18,
                            color: theme.textSecondary,
                          ),
                          SizedBox(width: AppDimensions.spacingXs),
                          Text(
                            data.timeRange,
                            style: typography.captionLight.copyWith(
                              color: theme.textSecondary,
                            ),
                          ),
                          SizedBox(width: AppDimensions.spacingSm),
                          Text(
                            '•',
                            style: typography.captionLight.copyWith(
                              color: theme.textSecondary,
                            ),
                          ),
                          SizedBox(width: AppDimensions.spacingXs),
                          Text(
                            data.statusLabel,
                            style: typography.captionBold.copyWith(
                              color: data.statusColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimensions.spacingVerticalMd),
                      Divider(height: 1, color: theme.borderDefault),
                      SizedBox(height: AppDimensions.spacingVerticalMd),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              data.registeredLabel,
                              style: typography.captionBold.copyWith(
                                color: theme.textPrimary,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            AppAssets.messagesIcon,
                            alignment: Alignment.center,
                            height: 18.h,
                            colorFilter: ColorFilter.mode(
                              theme.brandPrimary,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: AppDimensions.spacingSm),
                          SvgPicture.asset(
                            AppAssets.menuIcon,
                            alignment: Alignment.center,
                            height: 18.h,
                            colorFilter: ColorFilter.mode(
                              theme.brandPrimary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 4.w,
                    decoration: BoxDecoration(
                      color: theme.brandPrimary,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusLg,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
