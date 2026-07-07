import 'package:flutter/material.dart';

import '../../constant/app_dimensions.dart';
import '../../theme/app_theme_extension.dart';

class AppCarouselDots extends StatelessWidget {
  const AppCarouselDots({
    super.key,
    required this.count,
    required this.currentIndex,
    this.onDotTap,
    this.dotSize = 8,
    this.spacing = AppDimensions.spacingSm,
  });

  final int count;
  final int currentIndex;
  final ValueChanged<int>? onDotTap;
  final double dotSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;

        return Padding(
          padding: EdgeInsets.only(left: index == 0 ? 0 : spacing),
          child: GestureDetector(
            onTap: onDotTap != null ? () => onDotTap!(index) : null,
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? theme.brandPrimary : theme.buttonInactive,
              ),
            ),
          ),
        );
      }),
    );
  }
}
