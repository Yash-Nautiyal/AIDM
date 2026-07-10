import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/badge/app_status_badge.dart';
import 'package:aidm/feature/webinar/domain/entities/webinar.dart';
import 'package:aidm/feature/webinar/presentation/utils/webinar_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class WebinarSummaryCard extends StatelessWidget {
  const WebinarSummaryCard({
    super.key,
    required this.webinar,
    this.onEdit,
    this.showWebinarId = false,
    this.onCopyId,
  });

  final Webinar webinar;
  final VoidCallback? onEdit;
  final bool showWebinarId;
  final VoidCallback? onCopyId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingXl,
        vertical: AppDimensions.spacingXl,
      ),
      decoration: BoxDecoration(
        gradient: theme.gradientBrandPurple,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        boxShadow: const [
          BoxShadow(
            color: Color(0x403B5BDB),
            offset: Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppStatusBadge(label: webinar.statusBadgeLabel),
              const Spacer(),
              if (onEdit != null)
                GestureDetector(
                  onTap: onEdit,
                  child: SvgPicture.asset(
                    AppAssets.editIcon,
                    width: AppDimensions.iconSizeMd,
                    height: AppDimensions.iconSizeMd,
                  ),
                ),
            ],
          ),
          SizedBox(height: AppDimensions.spacingVerticalLg),
          Text(
            webinar.title,
            style: typography.h3.copyWith(color: theme.brandPrimaryTint),
          ),
          SizedBox(height: AppDimensions.spacingVerticalSm),
          Text(
            webinar.dateTimeLabel,
            style: typography.body.copyWith(
              color: theme.brandPrimaryTint.withValues(alpha: 0.92),
            ),
          ),
          SizedBox(height: AppDimensions.spacingVerticalXs),
          Text(
            webinar.timeZoneDurationLabel,
            style: typography.body.copyWith(
              color: theme.brandPrimaryTint.withValues(alpha: 0.92),
            ),
          ),
          if (showWebinarId) ...[
            SizedBox(height: AppDimensions.spacingVerticalLg),
            Divider(
              height: 1,
              thickness: 1,
              color: theme.brandPrimaryTint.withValues(alpha: 0.25),
            ),
            SizedBox(height: AppDimensions.spacingVerticalLg),
            Row(
              children: [
                Text(
                  'Webinar ID',
                  style: typography.bodyMedium.copyWith(
                    color: theme.brandPrimaryTint,
                  ),
                ),
                SizedBox(width: AppDimensions.spacingSm),
                Expanded(
                  child: _InlineCopyField(
                    value: webinar.inviteLink,
                    onCopy:
                        onCopyId ??
                        () => Clipboard.setData(
                          ClipboardData(text: webinar.inviteLink),
                        ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _InlineCopyField extends StatelessWidget {
  const _InlineCopyField({required this.value, required this.onCopy});

  final String value;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingVerticalMd,
      ),
      decoration: BoxDecoration(
        color: theme.brandPrimaryTint.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: typography.bodyMedium.copyWith(
                color: theme.brandPrimaryTint,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: AppDimensions.spacingSm),
          GestureDetector(
            onTap: onCopy,
            child: SvgPicture.asset(
              AppAssets.copyIcon,
              width: AppDimensions.iconSizeMd,
              height: AppDimensions.iconSizeMd,
              colorFilter: ColorFilter.mode(
                theme.brandPrimaryTint,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
