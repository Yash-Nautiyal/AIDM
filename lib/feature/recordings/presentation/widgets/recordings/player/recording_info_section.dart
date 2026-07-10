import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/feature/recordings/domain/entities/recording.dart';
import 'package:aidm/feature/recordings/presentation/utils/recording_extensions.dart';
import 'package:flutter/material.dart';

class RecordingInfoSection extends StatelessWidget {
  const RecordingInfoSection({
    super.key,
    required this.recording,
    this.onShare,
    this.onDownload,
  });

  final Recording recording;
  final VoidCallback? onShare;
  final VoidCallback? onDownload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.pagePadding,
        AppDimensions.spacingVerticalLg,
        AppDimensions.pagePadding,
        AppDimensions.spacingVerticalMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            recording.title,
            style: typography.h3.copyWith(color: theme.textPrimary),
          ),
          SizedBox(height: AppDimensions.spacingVerticalXs),
          Text(
            '${recording.date.recordingDateLabel} · ${recording.duration.recordingDurationLabel} · ${recording.attendedCount} attended',
            style: typography.captionLight.copyWith(color: theme.textSecondary),
          ),
          SizedBox(height: AppDimensions.spacingVerticalLg),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Share',
                  onPressed: onShare,
                ),
              ),
              SizedBox(width: AppDimensions.spacingMd),
              Expanded(
                child: AppButton(
                  label: 'Download',
                  type: AppButton1Type.secondary,
                  onPressed: onDownload,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
