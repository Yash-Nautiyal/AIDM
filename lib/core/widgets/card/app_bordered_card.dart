import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:flutter/material.dart';

class AppBorderedCard extends StatelessWidget {
  const AppBorderedCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundPage,
        border: Border.all(color: theme.borderDefault),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      child: child,
    );
  }
}
