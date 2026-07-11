import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarEmptyState extends StatelessWidget {
  const CalendarEmptyState({super.key, required this.onConnectTap});

  final VoidCallback onConnectTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.pagePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You haven’t connect you calendar yet. Connect now to sync webinars automatically.',
              style: typography.bodyMedium.copyWith(color: theme.textSecondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.spacingVertical2xl),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onConnectTap,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingLg,
                    vertical: AppDimensions.spacingVerticalMd,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppAssets.calendar2Icon,
                        width: AppDimensions.iconSizeLg,
                        height: AppDimensions.iconSizeLg,
                        colorFilter: ColorFilter.mode(
                          theme.brandPrimary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: AppDimensions.spacingSm),
                      Text(
                        'Connect Calendar',
                        style: typography.label.copyWith(
                          color: theme.brandPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
