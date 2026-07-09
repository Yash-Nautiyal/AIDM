import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeWebinarDateFilter extends StatelessWidget {
  const HomeWebinarDateFilter({
    super.key,
    required this.label,
    this.onPrevTap,
    this.onNextTap,
    this.onCalendarTap,
  });

  final String label;
  final VoidCallback? onPrevTap;
  final VoidCallback? onNextTap;
  final VoidCallback? onCalendarTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Row(
      children: [
        _ChevronButton(
          icon: Icons.chevron_left_rounded,
          onTap: onPrevTap,
          theme: theme,
        ),
        SizedBox(width: AppDimensions.spacingSm),
        Expanded(
          child: Text(
            label,
            style: typography.bodySemibold.copyWith(color: theme.textPrimary),
          ),
        ),
        _ChevronButton(
          icon: Icons.chevron_right_rounded,
          onTap: onNextTap,
          theme: theme,
        ),
        SizedBox(width: AppDimensions.spacingMd),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onCalendarTap,
            borderRadius: BorderRadius.circular(999),
            splashColor: theme.brandPrimary.withValues(alpha: 0.10),
            highlightColor: theme.brandPrimary.withValues(alpha: 0.06),
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.spacingSm),
              child: SvgPicture.asset(
                AppAssets.calendar2Icon,
                alignment: Alignment.center,
                height: 22.h,
                colorFilter: ColorFilter.mode(
                  theme.brandPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChevronButton extends StatelessWidget {
  const _ChevronButton({
    required this.icon,
    required this.onTap,
    required this.theme,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final AppThemeExtension theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        splashColor: theme.brandPrimary.withValues(alpha: 0.08),
        highlightColor: theme.brandPrimary.withValues(alpha: 0.04),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spacingXs),
          child: Icon(icon, color: theme.textPrimary, size: 26),
        ),
      ),
    );
  }
}
