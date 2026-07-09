import 'package:flutter/material.dart';

import '../../constant/app_dimensions.dart';
import '../../theme/app_theme_extension.dart';

class AppDatePickerCard extends StatelessWidget {
  const AppDatePickerCard({
    super.key,
    required this.child,
    this.transparent = false,
    this.showShadow = true,
  });

  final Widget child;
  final bool transparent;
  final bool showShadow;

  static Color backgroundColor(
    AppThemeExtension theme,
    Brightness brightness,
  ) {
    return brightness == Brightness.dark
        ? theme.backgroundDarkSurface
        : theme.backgroundPage;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final brightness = Theme.of(context).brightness;
    final background = transparent ? Colors.transparent : backgroundColor(theme, brightness);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimensions.spacing2xl),
        boxShadow: showShadow && !transparent
            ? const [
                BoxShadow(
                  color: Color(0x1A000000),
                  offset: Offset(0, 4),
                  blurRadius: 24,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.spacing2xl),
        child: child,
      ),
    );
  }
}
