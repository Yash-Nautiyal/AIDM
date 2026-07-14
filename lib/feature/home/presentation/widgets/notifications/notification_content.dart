import 'package:aidm/core/constant/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/app_dimensions.dart';
import '../../../../../core/theme/app_theme_extension.dart';
import '../../../../../core/theme/typography/app_typography_extension.dart';
import '../../../../../core/utils/common/file_utils.dart';
import '../../../domain/entities/notification.dart';
import '../../utils/notification_extensions.dart';

class NotificationContent extends StatelessWidget {
  const NotificationContent({super.key, required this.data});

  final NotificationTileData data;

  @override
  Widget build(BuildContext context) {
    return switch (data.type) {
      NotificationTileType.comment => _CommentContent(data: data),
      NotificationTileType.system => _SystemContent(data: data),
      NotificationTileType.attachment => _AttachmentContent(data: data),
      NotificationTileType.event => _EventUpdateContent(data: data),
    };
  }
}

class _AuthorText extends StatelessWidget {
  const _AuthorText({required this.author});

  final String author;

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Text(author, style: typography.bodyMedium);
  }
}

class _CommentContent extends StatelessWidget {
  const _CommentContent({required this.data});

  final NotificationTileData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AuthorText(author: data.author ?? ''),
        if (data.comment != null) ...[
          SizedBox(height: AppDimensions.spacingVerticalXs),
          Text(
            data.comment!,
            style: typography.body.copyWith(color: theme.textSecondary),
          ),
        ],
      ],
    );
  }
}

class _SystemContent extends StatelessWidget {
  const _SystemContent({required this.data});

  final NotificationTileData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Row(
      children: [
        _AuthorText(author: data.author ?? ''),
        SizedBox(width: AppDimensions.spacingXs),
        Text(
          data.systemMessage?.toSystemMessageText ?? '',
          style: typography.bodyMedium.copyWith(color: theme.textSecondary),
        ),
      ],
    );
  }
}

class _AttachmentContent extends StatelessWidget {
  const _AttachmentContent({required this.data});

  final NotificationTileData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AuthorText(author: data.author ?? ''),
        if (data.attachment != null) ...[
          SizedBox(height: AppDimensions.spacingVerticalXs),
          Row(
            children: [
              SvgPicture.asset(AppAssets.linkIcon),
              SizedBox(width: AppDimensions.spacingXs),
              Text(
                FileUtils.getExtensionFromMime(data.attachment ?? ''),
                style: typography.captionLight.copyWith(
                  color: theme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _EventUpdateContent extends StatelessWidget {
  const _EventUpdateContent({required this.data});

  final NotificationTileData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                data.eventTitle ?? '',
                style: typography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.textPrimary,
                ),
              ),
            ),
            if (data.calendarDay != null)
              SvgPicture.asset(
                AppAssets.calendarDatedIcon,
                width: AppDimensions.iconSizeLg,
                height: AppDimensions.iconSizeLg,
              ),
          ],
        ),
        SizedBox(height: AppDimensions.spacingVerticalXs),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: data.eventActor,
                style: typography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.textPrimary,
                ),
              ),
              TextSpan(
                text: ' ${data.eventAction ?? ''}',
                style: typography.bodyMedium.copyWith(
                  color: theme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
