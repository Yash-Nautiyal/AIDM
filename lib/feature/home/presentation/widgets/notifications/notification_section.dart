import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/notification.dart';
import 'notification_tile.dart';

class NotificationSection extends StatelessWidget {
  const NotificationSection({super.key, required this.data});

  final NotificationSectionData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          data.title,
          style: typography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.textPrimary,
          ),
        ),
        SizedBox(height: AppDimensions.spacingVerticalLg),
        ...data.items.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: AppDimensions.spacingVerticalMd),
            child: NotificationTile(data: item),
          ),
        ),
      ],
    );
  }
}
