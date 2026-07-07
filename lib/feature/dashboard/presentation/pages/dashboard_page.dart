import 'package:flutter/material.dart';

import 'package:aidm/feature/calendar/presentation/pages/calendar_page.dart';
import 'package:aidm/feature/more/presenation/pages/more_page.dart';
import 'package:aidm/feature/recordings/presentation/pages/recordings_page.dart';
import 'package:aidm/feature/webinar/presentation/pages/webinar_page.dart';

import '../../../../core/constant/app_animations.dart';
import '../../../../core/constant/app_dimensions.dart';

import '../../../../core/theme/app_theme_extension.dart';

import '../../../../core/widgets/button/app_button1.dart';
import '../../../../core/widgets/button/app_button2.dart';
import '../../../../core/widgets/input/app_input2.dart';
import '../../../../core/widgets/input/app_input1.dart';
import '../../../../core/widgets/nav/app_navbar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = AppNavBarItem.dashboard.index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final selectedItem = AppNavbar.items[_selectedIndex];

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: AppAnimations.contentDuration,
          switchInCurve: AppAnimations.standardCurve,
          switchOutCurve: AppAnimations.exitCurve,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, AppAnimations.titleSlideOffset),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Text(
            selectedItem.label,
            key: ValueKey<String>(selectedItem.label),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: AppAnimations.contentDuration,
        switchInCurve: AppAnimations.standardCurve,
        switchOutCurve: AppAnimations.exitCurve,
        transitionBuilder: (child, animation) {
          final slideAnimation = CurvedAnimation(
            parent: animation,
            curve: AppAnimations.standardCurve,
          );

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, AppAnimations.contentSlideOffset),
                end: Offset.zero,
              ).animate(slideAnimation),
              child: child,
            ),
          );
        },
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [...previousChildren, ?currentChild],
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_selectedIndex),
          child: _buildBodyForIndex(_selectedIndex),
        ),
      ),
      bottomNavigationBar: AppNavbar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  Widget _buildBodyForIndex(int index) {
    return switch (AppNavbar.items[index]) {
      AppNavBarItem.dashboard => _buildDashboardContent(),
      AppNavBarItem.webinars => const WebinarPage(),
      AppNavBarItem.calendar => const CalendarPage(),
      AppNavBarItem.recordings => const RecordingsPage(),
      AppNavBarItem.more => const MorePage(),
    };
  }

  Widget _buildDashboardContent() {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Input field',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingMd),
          const AppInput(),
          const SizedBox(height: AppDimensions.spacing3xl),
          Text(
            'Input field 2',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingMd),
          const AppInput2(),
          const SizedBox(height: AppDimensions.spacing3xl),
          Text(
            'Buttons',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingMd),
          AppButton1(label: 'Button', onPressed: () {}),
          const SizedBox(height: AppDimensions.spacingMd),
          AppButton1(label: 'Button', isLoading: true, onPressed: () {}),
          const SizedBox(height: AppDimensions.spacingMd),
          const AppButton1(label: 'Button', enabled: false),
          const SizedBox(height: AppDimensions.spacingMd),
          Text(
            'Buttons 2',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingMd),
          AppButton2(
            label: 'Button',
            variant: AppButton2Variant.secondary,
            onPressed: () {},
          ),
          const SizedBox(height: AppDimensions.spacingMd),
          AppButton2(
            label: 'Create Webinar',
            variant: AppButton2Variant.tertiary,
            onPressed: () {},
          ),
          const SizedBox(height: AppDimensions.spacingMd),
          AppButton2(
            label: 'Create Webinar',
            isLoading: true,
            variant: AppButton2Variant.tertiary,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
