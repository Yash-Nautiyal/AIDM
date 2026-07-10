import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/app_assets.dart';
import '../../../../../core/constant/app_dimensions.dart';
import '../../../../../core/theme/app_theme_extension.dart';
import '../../../../../core/theme/typography/app_typography_extension.dart';
import '../../../domain/entities/notification.dart';

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({super.key, required this.type});

  final NotificationTileType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Row(
      children: [
        _HeaderIcon(type: type, color: theme.textSecondary),
        SizedBox(width: AppDimensions.spacingXs),
        Expanded(child: _HeaderLabel(type: type)),
      ],
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({required this.type, required this.color});

  final NotificationTileType type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      NotificationTileType.comment => SvgPicture.asset(
        AppAssets.messageIcon,
        width: AppDimensions.iconSizeMd,
        height: AppDimensions.iconSizeMd,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
      NotificationTileType.attachment => SvgPicture.asset(
        AppAssets.paperClipIcon,
        width: AppDimensions.iconSizeMd,
        height: AppDimensions.iconSizeMd,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _HeaderLabel extends StatelessWidget {
  const _HeaderLabel({required this.type});

  final NotificationTileType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return switch (type) {
      NotificationTileType.comment => Text(
        'Commented on',
        style: typography.captionLight.copyWith(color: theme.textSecondary),
      ),
      NotificationTileType.attachment => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Added attachment on',
            style: typography.captionLight.copyWith(color: theme.textSecondary),
          ),
          SvgPicture.asset(
            AppAssets.appLogo,
            width: AppDimensions.iconSizeMd,
            height: AppDimensions.iconSizeMd,
          ),
        ],
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
