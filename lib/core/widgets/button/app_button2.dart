import 'package:aidm/core/theme/app_colors.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../constant/app_dimensions.dart';
import '../../theme/app_theme_extension.dart';
import '../../theme/typography/app_typography_extension.dart';

enum AppButton2Variant { secondary, tertiary }

class AppButton2 extends StatelessWidget {
  const AppButton2({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButton2Variant.secondary,
    this.isLoading = false,
    this.enabled = true,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButton2Variant variant;
  final bool isLoading;
  final bool enabled;
  final bool expand;

  bool get _isInteractive => enabled && !isLoading && onPressed != null;

  bool get _isTertiary => variant == AppButton2Variant.tertiary;

  Color _backgroundColor(AppThemeExtension theme) {
    if (!enabled) return theme.buttonInactive;
    if (isLoading) {
      return switch (variant) {
        AppButton2Variant.secondary =>
          theme.buttonBackgroundSecondary.withValues(alpha: 0.6),
        AppButton2Variant.tertiary => theme.buttonBackgroundTertiary.withValues(
          alpha: 0.6,
        ),
      };
    }
    return switch (variant) {
      AppButton2Variant.secondary => theme.buttonBackgroundSecondary,
      AppButton2Variant.tertiary => theme.buttonBackgroundTertiary,
    };
  }

  Color _textColor(AppThemeExtension theme) {
    if (_isTertiary) return AppColors.textSecondary;
    return theme.brandPrimaryTint;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final backgroundColor = _backgroundColor(theme);
    final textColor = _textColor(theme);

    final borderRadius = BorderRadius.horizontal(
      left: Radius.circular(AppDimensions.radiusSm),
      right: Radius.circular(AppDimensions.radiusSm),
    );

    final button = Material(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: _isTertiary
            ? BorderSide(
                color: theme.buttonTertiaryBorder.withValues(alpha: 0.6),
                width: 1,
              )
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _isInteractive ? onPressed : null,
        splashColor: textColor.withValues(alpha: 0.12),
        highlightColor: textColor.withValues(alpha: 0.08),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing2xl),
          child: Center(
            child: Row(
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading) ...[
                  SizedBox(
                    width: 16.sp,
                    height: 16.sp,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: textColor,
                    ),
                  ),
                  SizedBox(width: AppDimensions.spacingSm),
                ],
                Text(label, style: typography.label.copyWith(color: textColor)),
              ],
            ),
          ),
        ),
      ),
    );

    return SizedBox(
      width: expand ? double.infinity : null,
      height: AppDimensions.buttonHeight,
      child: _isTertiary
          ? DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                boxShadow: theme.buttonShadow,
              ),
              child: button,
            )
          : button,
    );
  }
}
