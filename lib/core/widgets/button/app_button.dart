import 'package:flutter/material.dart';

import '../../theme/app_theme_extension.dart';

enum AppButtonVariant { primary, secondary, tertiary }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.enabled = true,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool enabled;
  final bool expand;

  bool get _isInteractive => enabled && !isLoading && onPressed != null;

  bool get _isButton2Style =>
      variant == AppButtonVariant.secondary ||
      variant == AppButtonVariant.tertiary;

  Color _backgroundColor(AppThemeExtension theme) {
    if (!enabled) return theme.buttonInactive;
    if (isLoading) {
      return switch (variant) {
        AppButtonVariant.primary =>
          theme.buttonBackgroundPrimary.withValues(alpha: 0.6),
        AppButtonVariant.secondary =>
          theme.buttonBackgroundSecondary.withValues(alpha: 0.6),
        AppButtonVariant.tertiary =>
          theme.buttonBackgroundTertiary.withValues(alpha: 0.6),
      };
    }
    return switch (variant) {
      AppButtonVariant.primary => theme.buttonBackgroundPrimary,
      AppButtonVariant.secondary => theme.buttonBackgroundSecondary,
      AppButtonVariant.tertiary => theme.buttonBackgroundTertiary,
    };
  }

  Color _textColor(AppThemeExtension theme) {
    if (variant == AppButtonVariant.tertiary) {
      return theme.textPrimary;
    }
    return theme.brandPrimaryTint;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final backgroundColor = _backgroundColor(theme);
    final textColor = _textColor(theme);

    final child = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2, color: textColor),
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
    );

    return SizedBox(
      width: expand ? double.infinity : null,
      height: 50,
      child: Material(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(_isButton2Style ? 12 : 16),
            right: Radius.circular(_isButton2Style ? 12 : 16),
          ),
          side: variant == AppButtonVariant.tertiary
              ? BorderSide(color: theme.buttonTertiaryBorder, width: 1)
              : BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _isInteractive ? onPressed : null,
          splashColor: textColor.withValues(alpha: 0.12),
          highlightColor: textColor.withValues(alpha: 0.08),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
