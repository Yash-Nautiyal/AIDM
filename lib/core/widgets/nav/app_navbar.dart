import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_theme_extension.dart';

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
    AppNavBarItem.dashboard => 'assets/icons/home.svg',
    AppNavBarItem.webinars => 'assets/icons/calendar1.svg',
    AppNavBarItem.calendar => 'assets/icons/calender2.svg',
    AppNavBarItem.recordings => 'assets/icons/recording.svg',
    AppNavBarItem.more => 'assets/icons/menu.svg',
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
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            offset: Offset(0, -5),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 74,
          child: Row(
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
    final iconColor = isSelected ? Colors.white : theme.textSecondary;
    final labelColor = isSelected ? theme.brandPrimary : theme.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? theme.brandPrimary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(
                item.iconAsset,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                height: 1.2,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
