import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/notification.dart';
import 'notification_content.dart';
import 'notification_header.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.data});

  final NotificationTileData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    final isNotComment =
        data.type == NotificationTileType.system ||
        data.type == NotificationTileType.event;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isNotComment) ...[
          NotificationHeader(type: data.type),
          SizedBox(height: AppDimensions.spacingVerticalMd),
        ],
        switch (data.type) {
          NotificationTileType.system => _buildSystemBody(),
          NotificationTileType.event => _buildEventBody(),
          _ => _buildDefaultBody(),
        },
        SizedBox(height: AppDimensions.spacingVerticalSm),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            data.timestamp,
            style: typography.captionLight.copyWith(color: theme.textTertiary),
          ),
        ),
        SizedBox(height: AppDimensions.spacingVerticalMd),
        Divider(height: 1, thickness: 1, color: theme.borderDefault),
      ],
    );
  }

  Widget _buildAvatar({double? radius}) {
    return CircleAvatar(
      radius: radius ?? AppDimensions.notificationAvatarRadius,
      backgroundColor: data.avatarColor,
    );
  }

  Widget _buildSystemBody() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(),
        SizedBox(width: AppDimensions.spacingMd),
        NotificationContent(data: data),
      ],
    );
  }

  Widget _buildEventBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(radius: AppDimensions.notificationEventAvatarRadius),
        SizedBox(width: AppDimensions.spacingMd),
        Expanded(child: NotificationContent(data: data)),
      ],
    );
  }

  Widget _buildDefaultBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(),
        SizedBox(width: AppDimensions.spacingMd),
        Expanded(child: NotificationContent(data: data)),
      ],
    );
  }
}
