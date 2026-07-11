import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/file_utils.dart';
import 'package:aidm/core/widgets/card/app_card.dart';
import 'package:aidm/core/widgets/popup/popup.dart';
import 'package:aidm/core/widgets/popup/responsive_popup.dart';
import 'package:aidm/core/widgets/popup/responsive_popup_item.dart';
import 'package:aidm/feature/more/presenation/widgets/attachment/file_type_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AttachmentOption { download, edit, delete }

class AttachmentItem {
  const AttachmentItem({
    required this.id,
    required this.title,
    required this.fileName,
    required this.sizeInBytes,
    required this.uploadedAt,
  });

  final String id;
  final String title;
  final String fileName;
  final int sizeInBytes;
  final DateTime uploadedAt;

  AttachmentItem copyWith({
    String? id,
    String? title,
    String? fileName,
    int? sizeInBytes,
    DateTime? uploadedAt,
  }) {
    return AttachmentItem(
      id: id ?? this.id,
      title: title ?? this.title,
      fileName: fileName ?? this.fileName,
      sizeInBytes: sizeInBytes ?? this.sizeInBytes,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}

class AttachmentListItem extends StatefulWidget {
  const AttachmentListItem({
    super.key,
    required this.item,
    this.onOptionSelected,
  });

  final AttachmentItem item;
  final ValueChanged<AttachmentOption>? onOptionSelected;

  @override
  State<AttachmentListItem> createState() => _AttachmentListItemState();
}

class _AttachmentListItemState extends State<AttachmentListItem> {
  final _layerLink = LayerLink();
  final _popupKey = GlobalKey();
  final _popupController = ResponsivePopupController();

  @override
  void dispose() {
    _popupController.dispose();
    super.dispose();
  }

  void _onOptionTap(AttachmentOption option) {
    _popupController.hide();
    widget.onOptionSelected?.call(option);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final item = widget.item;
    final meta =
        '${FileUtils.formatFileSize(item.sizeInBytes)} · '
        '${FileUtils.formatAttachmentDate(item.uploadedAt)}';

    return AppCard(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingLg,
        vertical: AppDimensions.spacingVerticalLg,
      ),
      child: Row(
        children: [
          FileTypeBadge(fileName: item.fileName),
          SizedBox(width: AppDimensions.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: typography.labelMedium.copyWith(
                    color: theme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppDimensions.spacingVerticalXs),
                Text(
                  item.fileName,
                  style: typography.captionLight.copyWith(
                    color: theme.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppDimensions.spacingVerticalXs),
                Text(
                  meta,
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
                onTap: () => _onOptionTap(AttachmentOption.download),
              ),
              const AppPopupDivider(),
              AppPopupItem(
                title: 'Edit',
                svgIcon: AppAssets.editIcon,
                onTap: () => _onOptionTap(AttachmentOption.edit),
              ),
              const AppPopupDivider(),
              AppPopupItem(
                title: 'Delete',
                svgIcon: AppAssets.deleteIcon,
                color: theme.textDanger,
                onTap: () => _onOptionTap(AttachmentOption.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
