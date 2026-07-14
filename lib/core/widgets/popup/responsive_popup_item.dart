import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppPopupItem extends StatelessWidget {
  const AppPopupItem({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.svgIcon,
    this.color,
  });

  final String title;
  final VoidCallback onTap;
  final IconData? icon;
  final String? svgIcon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final itemColor = color ?? theme.textPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingLg,
            vertical: AppDimensions.spacingVerticalMd,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 35.sp,
                child: Row(
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 20.sp, color: itemColor),
                      SizedBox(width: AppDimensions.spacingMd),
                    ],
                    if (svgIcon != null) ...[
                      SvgPicture.asset(
                        svgIcon!,
                        width: AppDimensions.iconSizeMd,
                        height: AppDimensions.iconSizeMd,
                        colorFilter: ColorFilter.mode(
                          itemColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: AppDimensions.spacingMd),
                    ],
                  ],
                ),
              ),

              Expanded(
                child: Text(
                  title,
                  style: typography.bodyMedium.copyWith(color: itemColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppPopupDivider extends StatelessWidget {
  const AppPopupDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Divider(height: 1, thickness: 1, color: theme.borderDefault);
  }
}
