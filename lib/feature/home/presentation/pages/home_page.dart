import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/widgets/button/app_floating_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/app_dimensions.dart';
import '../../../../core/widgets/nav/app_shell.dart';
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
      floatingActionButton: AppFloatingButton(onPressed: () {}),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeHeader(
                userName: 'Dunge',
                onNotificationsTap: () {
                  moveTo(context, const NotificationPage());
                },
              ),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              HomeUpgradeCard(onUpgradeTap: () {}),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              HomeMeetingRow(
                onStartTap: () => showStartWebinarSheet(context),
                onJoinTap: () => showJointWebinarSheet(context),
                onScheduleTap: () {
                  moveTo(context, const SchedulePage());
                },
                onRecordingsTap: () {
                  AppShell.maybeOf(context)?.onTabSelected(3);
                },
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
