import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/popup/popup.dart';
import 'package:aidm/core/widgets/popup/responsive_popup.dart';
import 'package:aidm/core/widgets/popup/responsive_popup_item.dart';
import 'package:aidm/feature/recordings/domain/entities/recording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecordingTileHeader extends StatefulWidget {
  const RecordingTileHeader({
    super.key,
    required this.recording,
    this.onOptionSelected,
  });

  final Recording recording;
  final ValueChanged<RecordingOption>? onOptionSelected;

  @override
  State<RecordingTileHeader> createState() => _RecordingTileHeaderState();
}

class _RecordingTileHeaderState extends State<RecordingTileHeader> {
  final _layerLink = LayerLink();
  final _popupKey = GlobalKey();
  final _popupController = ResponsivePopupController();

  @override
  void dispose() {
    _popupController.dispose();
    super.dispose();
  }

  void _onOptionTap(RecordingOption option) {
    _popupController.hide();
    widget.onOptionSelected?.call(option);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.recording.title,
                style: typography.labelLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppDimensions.spacingVerticalXs),
              Text(
                widget.recording.teamAndLocation,
                style: typography.captionLight.copyWith(
                  color: theme.textTertiary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: AppDimensions.spacingSm),
        AppPopup(
          popupAnchorKey: _popupKey,
          layerLink: _layerLink,
          popupController: _popupController,
          width: appPopupMenuWidth,
          preferredPosition: PopupPreferredPosition.bottom,
          crossAxisAlignment: PopupCrossAxisAlignment.end,
          trigger: Padding(
            padding: EdgeInsets.all(AppDimensions.spacingXs),
            child: SvgPicture.asset(
              AppAssets.menuIcon,
              colorFilter: ColorFilter.mode(
                theme.textSecondary,
                BlendMode.srcIn,
              ),
              width: AppDimensions.iconSizeMd,
              height: AppDimensions.iconSizeMd,
            ),
          ),
          items: [
            AppPopupItem(
              title: 'Download',
              svgIcon: AppAssets.downloadIcon,
              onTap: () => _onOptionTap(RecordingOption.download),
            ),
            const AppPopupDivider(),
            AppPopupItem(
              title: 'Share',
              svgIcon: AppAssets.shareIcon,
              onTap: () => _onOptionTap(RecordingOption.share),
            ),
            const AppPopupDivider(),
            AppPopupItem(
              title: 'Delete',
              svgIcon: AppAssets.deleteIcon,
              color: theme.textDanger,
              onTap: () => _onOptionTap(RecordingOption.delete),
            ),
          ],
        ),
      ],
    );
  }
}
