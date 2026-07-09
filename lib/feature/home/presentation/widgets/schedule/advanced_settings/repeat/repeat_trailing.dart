import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/constant/app_animations.dart';
import '../../../../../../../core/theme/app_theme_extension.dart';

class UnfoldMoreStepper extends StatelessWidget {
  const UnfoldMoreStepper({
    super.key,
    required this.onIncrement,
    required this.onDecrement,
  });

  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28.w,
      height: 28.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const UnfoldMoreTrailingIcon(),
          Column(
            children: [
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(onTap: onIncrement),
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(onTap: onDecrement),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UnfoldMoreTrailingIcon extends StatelessWidget {
  const UnfoldMoreTrailingIcon({super.key, this.isExpanded = false});

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return AppAnimations.expandChevron(
      isExpanded: isExpanded,
      child: Icon(
        Icons.unfold_more_rounded,
        color: theme.textSecondary,
        size: 20.sp,
      ),
    );
  }
}
