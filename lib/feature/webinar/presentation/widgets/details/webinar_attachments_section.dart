import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/entities/attachments.dart';

class WebinarAttachmentsSection extends StatelessWidget {
  const WebinarAttachmentsSection({
    super.key,
    required this.attachments,
    required this.onUpload,
    required this.onRemove,
  });

  final List<WebinarAttachment> attachments;
  final VoidCallback onUpload;
  final ValueChanged<WebinarAttachment> onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final hasAttachments = attachments.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimensions.spacingLg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        border: Border.all(color: theme.borderDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attachments',
            style: typography.bodySemibold.copyWith(color: theme.textPrimary),
          ),
          SizedBox(height: AppDimensions.spacingVerticalMd),
          Divider(height: 1, thickness: 1, color: theme.borderDefault),
          if (!hasAttachments) ...[
            SizedBox(height: AppDimensions.spacingVertical2xl),
            Center(
              child: Column(
                children: [
                  Text(
                    'No attachments added yet',
                    style: typography.bodyMedium.copyWith(
                      color: theme.textSecondary,
                    ),
                  ),
                  SizedBox(height: AppDimensions.spacingVerticalLg),
                  _UploadButton(onTap: onUpload),
                ],
              ),
            ),
            SizedBox(height: AppDimensions.spacingVerticalLg),
          ] else ...[
            SizedBox(height: AppDimensions.spacingVerticalMd),
            ...attachments.map(
              (attachment) => _AttachmentTile(
                attachment: attachment,
                onRemove: () => onRemove(attachment),
              ),
            ),
            SizedBox(height: AppDimensions.spacingVerticalMd),
            Center(child: _UploadButton(onTap: onUpload)),
            SizedBox(height: AppDimensions.spacingVerticalSm),
          ],
        ],
      ),
    );
  }
}

class _UploadButton extends StatelessWidget {
  const _UploadButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Material(
      color: theme.backgroundPage,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing2xl,
            vertical: AppDimensions.spacingVerticalMd,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            border: Border.all(color: theme.brandPrimary),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppAssets.uploadIcon,
                width: 16.sp,
                height: 16.sp,
                colorFilter: ColorFilter.mode(
                  theme.brandPrimary,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: AppDimensions.spacingSm),
              Text(
                'Upload',
                style: typography.labelMedium.copyWith(
                  color: theme.brandPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AttachmentTile extends StatelessWidget {
  const _AttachmentTile({required this.attachment, required this.onRemove});

  final WebinarAttachment attachment;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.spacingVerticalSm),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.paperClipIcon,
            width: 16.sp,
            height: 16.sp,
            colorFilter: ColorFilter.mode(theme.brandPrimary, BlendMode.srcIn),
          ),
          SizedBox(width: AppDimensions.spacingSm),
          Expanded(
            child: Text(
              attachment.name,
              style: typography.bodyMedium.copyWith(color: theme.textPrimary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: onRemove,
            visualDensity: VisualDensity.compact,
            icon: SvgPicture.asset(
              AppAssets.deleteIcon,
              width: 16.sp,
              height: 16.sp,
              colorFilter: ColorFilter.mode(theme.textDanger, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
