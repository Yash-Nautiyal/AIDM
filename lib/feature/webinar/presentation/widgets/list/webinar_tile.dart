import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:aidm/core/widgets/card/app_card.dart';
import 'package:aidm/feature/webinar/domain/entities/webinar.dart';
import 'package:aidm/feature/webinar/presentation/utils/webinar_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/app_assets.dart';

class WebinarTile extends StatelessWidget {
  const WebinarTile({
    super.key,
    required this.webinar,
    required this.onTap,
    required this.onActionTap,
  });

  final Webinar webinar;
  final VoidCallback onTap;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final action = webinar.listAction;
    final isPrimary = action == WebinarListAction.startNow;

    return InkWell(
      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      onTap: onTap,
      child: AppCard(
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.spacingLg + 4.w,
                  AppDimensions.spacingLg,
                  AppDimensions.spacingLg,
                  AppDimensions.spacingLg,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            webinar.title,
                            style: typography.labelLarge.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppDimensions.spacingVerticalXs),
                          Text(
                            webinar.teamAndLocation,
                            style: typography.captionLight.copyWith(
                              color: theme.textSecondary,
                            ),
                          ),
                          SizedBox(height: AppDimensions.spacingVerticalMd),
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.alarmIcon,
                                width: AppDimensions.iconSizeMd,
                                height: AppDimensions.iconSizeMd,
                              ),
                              SizedBox(width: AppDimensions.spacingXs),
                              Flexible(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: webinar.listTimeRangeLabel,
                                        style: typography.captionLight.copyWith(
                                          color: theme.textSecondary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' · ',
                                        style: typography.captionLight.copyWith(
                                          color: theme.textSecondary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: webinar.countdownLabel(),
                                        style: typography.captionBold.copyWith(
                                          color: webinar.countdownColor(theme),
                                        ),
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: AppDimensions.spacingMd),
                    _ActionButton(
                      label: isPrimary ? 'Start Now' : 'Details',
                      isPrimary: isPrimary,
                      onTap: onActionTap,
                    ),
                  ],
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

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Material(
      color: isPrimary ? theme.brandPrimary : theme.backgroundPage,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingLg,
            vertical: AppDimensions.spacingVerticalMd,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            border: isPrimary ? null : Border.all(color: theme.brandPrimary),
          ),
          child: Text(
            label,
            style: typography.labelMedium.copyWith(
              color: isPrimary ? theme.brandPrimaryTint : theme.brandPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
