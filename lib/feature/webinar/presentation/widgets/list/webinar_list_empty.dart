import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:flutter/material.dart';

class WebinarListEmpty extends StatelessWidget {
  const WebinarListEmpty({super.key, required this.onSchedule});

  final VoidCallback onSchedule;

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
            Image.asset(
              AppAssets.calendarWebinarImg,
              width: 120.w,
              height: 120.w,
            ),
            SizedBox(height: AppDimensions.spacingVertical2xl),
            Text(
              'No webinars yet',
              style: typography.h3.copyWith(color: theme.textPrimary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.spacingVerticalSm),
            Text(
              'Schedule your first webinar and start\nreaching your audience.',
              style: typography.bodyMedium.copyWith(color: theme.textSecondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.spacingVertical2xl),
            SizedBox(
              width: 160.w,
              child: AppButton(
                label: 'Schedule',
                onPressed: onSchedule,
                expand: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
