import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../constant/app_dimensions.dart';
import '../../theme/app_theme_extension.dart';
import '../../theme/typography/app_typography_extension.dart';

enum AppButton1Type { primary, secondary }

class AppButton1 extends StatelessWidget {
  const AppButton1({
    super.key,
    required this.label,
    this.onPressed,
    this.type = AppButton1Type.primary,
    this.isLoading = false,
    this.enabled = true,
    this.expand = true,
    this.height,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButton1Type type;
  final bool isLoading;
  final bool enabled;
  final bool expand;
  final double? height;
  bool get _isInteractive => enabled && !isLoading && onPressed != null;

  Color _backgroundColor(AppThemeExtension theme) {
    if (isLoading) return theme.buttonBackgroundPrimary.withValues(alpha: 0.6);

    if (type == AppButton1Type.secondary) {
      return enabled ? theme.backgroundPage : theme.buttonInactive;
    }

    if (!enabled) return theme.buttonInactive;
    return theme.buttonBackgroundPrimary;
  }

  Color _textColor(AppThemeExtension theme) {
    if (isLoading) return theme.brandPrimaryTint;

    if (type == AppButton1Type.secondary) {
      return enabled ? theme.brandPrimary : theme.textSecondary;
    }

    if (!enabled) return theme.textSecondary;
    return theme.brandPrimaryTint;
  }

  Color? _borderColor(AppThemeExtension theme) {
    if (type == AppButton1Type.secondary) {
      return enabled ? theme.brandPrimary : null;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final backgroundColor = _backgroundColor(theme);
    final textColor = _textColor(theme);
    final borderColor = _borderColor(theme);

    final borderRadius = BorderRadius.horizontal(
      left: Radius.circular(AppDimensions.radiusMd),
      right: Radius.circular(AppDimensions.radiusMd),
    );

    return SizedBox(
      width: expand ? double.infinity : null,
      height: height ?? AppDimensions.buttonHeight,
      child: Material(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(color: borderColor ?? Colors.transparent),
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
                  Text(
                    label,
                    style: typography.label.copyWith(color: textColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
