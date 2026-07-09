import 'package:flutter/material.dart';

import '../../../../core/constant/app_dimensions.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../widgets/home_header.dart';
import '../widgets/home_meeting_row.dart';
import '../widgets/home_upgrade_card.dart';
import '../widgets/home_webinar_cards.dart';
import '../widgets/home_webinar_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final webinars = [
      HomeWebinarCardData(
        title: 'Product Demo Day',
        teamAndLocation: 'Marketing team · India',
        timeRange: '11:00 - 12:30PM',
        statusLabel: 'In 4 mins',
        statusColor: theme.statusDraft,
        registeredLabel: '47 registered',
        date: DateTime.now(),
      ),
    ];
    return Scaffold(
      backgroundColor: theme.backgroundPage,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: theme.brandPrimary,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: AppDimensions.spacingVertical3xl,
            top: AppDimensions.spacingVerticalMd,
            left: AppDimensions.pagePadding,
            right: AppDimensions.pagePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HomeHeader(userName: 'Dunge'),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              HomeUpgradeCard(onUpgradeTap: () {}),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              HomeMeetingRow(
                onStartTap: () {},
                onJoinTap: () {},
                onScheduleTap: () {},
                onRecordingsTap: () {},
              ),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              HomeWebinarListView(
                title: 'No upcoming webinars',
                subtitle: 'The Scheduled webinars will be listed here',
                webinars: webinars,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
