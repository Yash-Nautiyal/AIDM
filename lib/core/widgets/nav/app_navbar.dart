import 'package:aidm/core/constant/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constant/app_animations.dart';
import '../../constant/app_dimensions.dart';
import '../../theme/app_theme_extension.dart';
import '../../theme/typography/app_typography_extension.dart';

enum AppNavBarItem { dashboard, webinars, calendar, recordings, more }

extension AppNavBarItemX on AppNavBarItem {
  String get label => switch (this) {
    AppNavBarItem.dashboard => 'Dashboard',
    AppNavBarItem.webinars => 'Webinars',
    AppNavBarItem.calendar => 'Calendar',
    AppNavBarItem.recordings => 'Recordings',
    AppNavBarItem.more => 'More',
  };

  String get iconAsset => switch (this) {
    AppNavBarItem.dashboard => AppAssets.homeIcon,
    AppNavBarItem.webinars => AppAssets.calendar1Icon,
    AppNavBarItem.calendar => AppAssets.calendar2Icon,
    AppNavBarItem.recordings => AppAssets.recordingIcon,
    AppNavBarItem.more => AppAssets.menuIcon,
  };
}

class AppNavbar extends StatelessWidget {
  const AppNavbar({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<AppNavBarItem> items = AppNavBarItem.values;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.backgroundPage,
        boxShadow: theme.bottomNavShadow,
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppDimensions.navBarHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / items.length;
              final contentTop =
                  (AppDimensions.navBarHeight -
                      AppDimensions.navContentHeight) /
                  2;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedPositioned(
                    duration: AppAnimations.navDuration,
                    curve: AppAnimations.standardCurve,
                    left:
                        currentIndex * itemWidth +
                        (itemWidth - AppDimensions.navPillWidth) / 2,
                    top: contentTop,
                    width: AppDimensions.navPillWidth,
                    height: AppDimensions.navPillHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: theme.brandPrimary,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.navPillRadius,
                        ),
                        boxShadow: theme.bottomNavShadow,
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(items.length, (index) {
                      return Expanded(
                        child: _NavBarItem(
                          item: items[index],
                          isSelected: index == currentIndex,
                          onTap: () => onTap(index),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final AppNavBarItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final iconColor = isSelected ? Colors.white : theme.textSecondary;
    final labelColor = isSelected ? theme.brandPrimary : theme.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: theme.brandPrimary.withValues(alpha: 0.08),
        highlightColor: theme.brandPrimary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppDimensions.navItemRadius),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.navPillHorizontalPadding,
                vertical: AppDimensions.navPillVerticalPadding,
              ),
              child: TweenAnimationBuilder<double>(
                duration: AppAnimations.navDuration,
                curve: AppAnimations.standardCurve,
                tween: Tween(
                  end: isSelected ? AppAnimations.navSelectedScale : 1,
                ),
                builder: (context, scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: TweenAnimationBuilder<Color?>(
                  duration: AppAnimations.navDuration,
                  curve: AppAnimations.standardCurve,
                  tween: ColorTween(end: iconColor),
                  builder: (context, color, _) {
                    return SvgPicture.asset(
                      item.iconAsset,
                      width: AppDimensions.navIconSize,
                      height: AppDimensions.navIconSize,
                      colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: AppDimensions.navLabelGap),
            AnimatedDefaultTextStyle(
              duration: AppAnimations.navDuration,
              curve: AppAnimations.standardCurve,
              style: typography.nav.copyWith(color: labelColor),
              child: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
