import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_colors.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/notification.dart';
import '../widgets/notifications/notification_section.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static const _sections = <NotificationSectionData>[
    NotificationSectionData(
      title: 'New',
      items: [
        NotificationTileData(
          type: NotificationTileType.comment,
          avatarColor: AppColors.brandPurpleTint,
          author: 'Jena',
          comment: 'This webinar is informative',
          timestamp: '1 min ago',
        ),
        NotificationTileData(
          type: NotificationTileType.system,
          avatarColor: AppColors.lightBlackScreen,
          author: 'Adam',
          systemMessage: NotificationTileSystemMessage.participantLeft,
          timestamp: '5 min ago',
        ),
        NotificationTileData(
          type: NotificationTileType.attachment,
          avatarColor: AppColors.brandPrimary,
          author: 'Minion',
          attachment: 'document.pdf',
          timestamp: '58 min ago',
        ),
      ],
    ),
    NotificationSectionData(
      title: 'Yesterday',
      items: [
        NotificationTileData(
          type: NotificationTileType.event,
          avatarColor: Color(0xFF52525B),
          eventTitle: 'Product demo',
          author: 'Jensen',
          eventAction: 'is not going',
          calendarDay: 12,
          timestamp: '6 days ago',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'Notification', showBack: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: AppDimensions.pagePadding,
                itemCount: _sections.length,
                separatorBuilder: (_, _) =>
                    SizedBox(height: AppDimensions.spacingVerticalSm),
                itemBuilder: (context, index) {
                  return NotificationSection(data: _sections[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
