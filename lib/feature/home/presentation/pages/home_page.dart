import 'package:flutter/material.dart';

import '../../../../core/constant/app_dimensions.dart';
import '../../../../core/theme/app_theme_extension.dart';
import 'notification_page.dart';
import 'schedule_page.dart';
import '../widgets/sections/home_header.dart';
import '../widgets/sections/home_meeting_row.dart';
import '../widgets/sections/home_upgrade_card.dart';
import '../widgets/sheets/join/join_webinar_sheet.dart';
import '../widgets/sheets/start/start_webinar_sheet.dart';
import '../widgets/webinar_list/home_webinar_cards.dart';
import '../widgets/sections/home_webinar_list.dart';

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
        shape: const CircleBorder(),
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
              HomeHeader(
                userName: 'Dunge',
                onNotificationsTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NotificationPage(),
                    ),
                  );
                },
              ),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              HomeUpgradeCard(onUpgradeTap: () {}),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              HomeMeetingRow(
                onStartTap: () => showStartWebinarSheet(context),
                onJoinTap: () => showJointWebinarSheet(context),
                onScheduleTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SchedulePage()),
                  );
                },
                onRecordingsTap: () {},
              ),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              HomeWebinarList(
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
