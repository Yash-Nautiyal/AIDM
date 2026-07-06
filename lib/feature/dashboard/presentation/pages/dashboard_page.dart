import 'package:aidm/core/widgets/input/app_input2.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/widgets/button/app_button.dart';
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
      appBar: AppBar(title: Text(selectedItem.label)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
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
            const SizedBox(height: 12),
            const AppInput(),
            const SizedBox(height: 32),
            Text(
              'Input field 2',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            const AppInput2(),
            const SizedBox(height: 32),
            Text(
              'Buttons',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            AppButton(label: 'Button', onPressed: () {}),
            const SizedBox(height: 12),
            AppButton(label: 'Button', isLoading: true, onPressed: () {}),
            const SizedBox(height: 12),
            const AppButton(label: 'Button', enabled: false),
            const SizedBox(height: 12),
            Text(
              'Buttons 2',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            AppButton(
              label: 'Button',
              variant: AppButtonVariant.secondary,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            AppButton(
              label: 'Create Webinar',
              variant: AppButtonVariant.tertiary,
              onPressed: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavbar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
