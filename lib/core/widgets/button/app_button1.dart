import 'package:flutter/material.dart';

import '../../constant/app_dimensions.dart';
import '../../theme/app_theme_extension.dart';

class AppButton1 extends StatelessWidget {
  const AppButton1({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final bool expand;

  bool get _isInteractive => enabled && !isLoading && onPressed != null;

  Color _backgroundColor(AppThemeExtension theme) {
    if (!enabled) return theme.buttonInactive;
    if (isLoading) {
      return theme.buttonBackgroundPrimary.withValues(alpha: 0.6);
    }
    return theme.buttonBackgroundPrimary;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final backgroundColor = _backgroundColor(theme);
    final textColor = theme.brandPrimaryTint;

    final borderRadius = BorderRadius.horizontal(
      left: Radius.circular(AppDimensions.radiusMd),
      right: Radius.circular(AppDimensions.radiusMd),
    );

    return SizedBox(
      width: expand ? double.infinity : null,
      height: 50,
      child: Material(
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
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
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                      color: textColor,
                    ),
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
