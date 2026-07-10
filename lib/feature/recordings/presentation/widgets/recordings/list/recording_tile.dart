import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/feature/recordings/domain/entities/recording.dart';
import '../../../utils/recording_extensions.dart';
import 'recording_thumbnail.dart';
import 'package:flutter/material.dart';

import 'recording_tile_header.dart';

class RecordingTile extends StatelessWidget {
  const RecordingTile({
    super.key,
    required this.recording,
    this.onTap,
    this.onOptionSelected,
  });

  final Recording recording;
  final VoidCallback? onTap;
  final ValueChanged<RecordingOption>? onOptionSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppDimensions.spacingVerticalMd,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecordingThumbnail(duration: recording.duration, onTap: onTap),
            SizedBox(width: AppDimensions.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecordingTileHeader(
                    recording: recording,
                    onOptionSelected: onOptionSelected,
                  ),
                  SizedBox(height: AppDimensions.spacingVerticalXs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${recording.attendedCount} attended',
                        style: typography.captionBold.copyWith(
                          color: theme.textSecondary,
                        ),
                      ),
                      Text(
                        recording.date.recordingDateLabel,
                        style: typography.captionLight.copyWith(
                          color: theme.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
