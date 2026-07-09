import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:flutter/material.dart';

import '../repeat/repeat_select_field.dart';
import '../prerecorded/show_prerecorded_recordings_sheet.dart';
import '../prerecorded/show_prerecorded_upload_sheet.dart';
import '../prerecorded/prerecorded_video_source_segment.dart';

class ScheduleAdvancedPrerecordedFields extends StatelessWidget {
  const ScheduleAdvancedPrerecordedFields({
    super.key,
    required this.videoSource,
    required this.selectedRecording,
    required this.uploadedFileName,
    required this.recordings,
    required this.onVideoSourceChanged,
    required this.onRecordingSelected,
    required this.onFileUploaded,
  });

  final PrerecordedVideoSource videoSource;
  final PrerecordedRecordingItem? selectedRecording;
  final String? uploadedFileName;
  final List<PrerecordedRecordingItem> recordings;

  final ValueChanged<PrerecordedVideoSource> onVideoSourceChanged;
  final ValueChanged<PrerecordedRecordingItem> onRecordingSelected;
  final ValueChanged<String> onFileUploaded;

  Future<void> _openRecordingsSheet(BuildContext context) async {
    final result = await showPrerecordedRecordingsSheet(
      context,
      recordings: recordings,
      selected: selectedRecording,
    );
    if (result == null) return;
    onRecordingSelected(result);
  }

  Future<void> _openUploadSheet(BuildContext context) async {
    final result = await showPrerecordedUploadSheet(context);
    if (result == null) return;
    onFileUploaded(result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Padding(
      padding: EdgeInsets.only(
        left: AppDimensions.spacingLg,
        right: AppDimensions.spacingLg,
        bottom: AppDimensions.spacingVerticalLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Video Source',
            style: typography.captionLight.copyWith(color: theme.textTertiary),
          ),
          SizedBox(height: AppDimensions.spacingSm),
          PrerecordedVideoSourceSegment(
            value: videoSource,
            onChanged: onVideoSourceChanged,
          ),
          SizedBox(height: AppDimensions.spacingVerticalMd),
          if (videoSource == PrerecordedVideoSource.recordings) ...[
            LabeledSelectField(
              label: 'Choose Recordings',
              value: selectedRecording?.title ?? 'Select a Recording',
              isExpanded: false,
              onTap: () => _openRecordingsSheet(context),
            ),
            SizedBox(height: AppDimensions.spacingSm),
            Text(
              'Select from completed recordings',
              style: typography.captionLight.copyWith(
                color: theme.textTertiary,
              ),
            ),
          ] else ...[
            Text(
              'Upload MP4',
              style: typography.captionLight.copyWith(
                color: theme.textTertiary,
              ),
            ),
            SizedBox(height: AppDimensions.spacingSm),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingLg,
                vertical: AppDimensions.spacingVertical2xl,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                border: Border.all(color: theme.borderDefault),
              ),
              child: Column(
                children: [
                  Text(
                    'MP4, VIDEO/MP4 files only',
                    style: typography.bodyMedium.copyWith(
                      color: theme.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppDimensions.spacingVerticalXs),
                  Text(
                    'Max size: 2 GB',
                    style: typography.caption.copyWith(
                      color: theme.textTertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (uploadedFileName != null) ...[
                    SizedBox(height: AppDimensions.spacingVerticalSm),
                    Text(
                      uploadedFileName!,
                      style: typography.caption.copyWith(
                        color: theme.brandPrimary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: AppDimensions.spacingVerticalLg),
                  AppButton(
                    label: 'Upload',
                    type: AppButton1Type.secondary,
                    onPressed: () => _openUploadSheet(context),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
