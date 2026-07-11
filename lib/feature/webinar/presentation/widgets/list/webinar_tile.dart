import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/tile/app_accent_list_tile.dart';
import 'package:aidm/core/widgets/tile/app_tile_action_button.dart';
import 'package:aidm/feature/webinar/domain/entities/webinar.dart';
import 'package:aidm/feature/webinar/presentation/utils/webinar_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WebinarTile extends StatelessWidget {
  const WebinarTile({
    super.key,
    required this.webinar,
    required this.onTap,
    required this.onActionTap,
  });

  final Webinar webinar;
  final VoidCallback onTap;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final action = webinar.listAction;
    final isPrimary = action == WebinarListAction.startNow;

    return AppAccentListTile(
      title: webinar.title,
      subtitle: webinar.teamAndLocation,
      onTap: onTap,
      meta: Row(
        children: [
          SvgPicture.asset(
            AppAssets.alarmIcon,
            width: AppDimensions.iconSizeMd,
            height: AppDimensions.iconSizeMd,
          ),
          SizedBox(width: AppDimensions.spacingXs),
          Flexible(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: webinar.listTimeRangeLabel,
                    style: typography.captionLight.copyWith(
                      color: theme.textSecondary,
                    ),
                  ),
                  TextSpan(
                    text: ' · ',
                    style: typography.captionLight.copyWith(
                      color: theme.textSecondary,
                    ),
                  ),
                  TextSpan(
                    text: webinar.countdownLabel(),
                    style: typography.captionBold.copyWith(
                      color: webinar.countdownColor(theme),
                    ),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      trailing: AppTileActionButton(
        label: isPrimary ? 'Start Now' : 'Details',
        isPrimary: isPrimary,
        onTap: onActionTap,
      ),
    );
  }
}
