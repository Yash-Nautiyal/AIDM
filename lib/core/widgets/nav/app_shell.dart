import 'package:aidm/core/routes/shell_routes.dart';
import 'package:flutter/material.dart';

import 'app_navbar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  static AppShellScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppShellScope>();
  }

  @override
  State<AppShell> createState() => _AppShellState();
}

class AppShellScope extends InheritedWidget {
  const AppShellScope({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required super.child,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  @override
  bool updateShouldNotify(AppShellScope oldWidget) {
    return selectedIndex != oldWidget.selectedIndex;
  }
}

class _AppShellState extends State<AppShell> {
  late int _currentIndex = widget.initialIndex;

  void _onTabSelected(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return AppShellScope(
      selectedIndex: _currentIndex,
      onTabSelected: _onTabSelected,
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: ShellRoutes.tabs),
        bottomNavigationBar: AppNavbar(
          currentIndex: _currentIndex,
          onTap: _onTabSelected,
        ),
      ),
    );
  }
}
