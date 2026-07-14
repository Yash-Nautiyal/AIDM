import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:aidm/core/widgets/card/app_card.dart';
import 'package:flutter/material.dart';

class AppAccentListTile extends StatelessWidget {
  const AppAccentListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.meta,
    this.trailing,
    this.onTap,
    this.accentColor,
  });

  final String title;
  final String subtitle;
  final Widget? meta;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final accent = accentColor ?? theme.brandPrimary;

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
                padding: EdgeInsets.only(
                  left: 20.sp,
                  right: 16.sp,
                  top: 16.sp,
                  bottom: 16.sp,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: typography.labelLarge.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppDimensions.spacingVerticalXs),
                          Text(
                            subtitle,
                            style: typography.captionLight.copyWith(
                              color: theme.textSecondary,
                            ),
                          ),
                          if (meta != null) ...[
                            SizedBox(height: AppDimensions.spacingVerticalMd),
                            meta!,
                          ],
                        ],
                      ),
                    ),
                    if (trailing != null) ...[
                      SizedBox(width: AppDimensions.spacingMd),
                      trailing!,
                    ],
                  ],
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 5.5.sp,
                    decoration: BoxDecoration(
                      color: accent,
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
