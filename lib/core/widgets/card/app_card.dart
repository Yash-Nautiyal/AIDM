import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const AppCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    return Container(
      padding: padding ?? EdgeInsets.all(AppDimensions.spacingLg),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? theme.backgroundInput
            : theme.backgroundPage,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        boxShadow: theme.cardShadow,
      ),
      child: child,
    );
  }
}
