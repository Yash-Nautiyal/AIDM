import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:aidm/core/widgets/bottom_sheet/show_app_bottom_sheet.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:flutter/material.dart';

class PrerecordedRecordingItem {
  const PrerecordedRecordingItem({
    required this.id,
    required this.title,
    required this.meta,
  });

  final String id;
  final String title;
  final String meta;
}

Future<PrerecordedRecordingItem?> showPrerecordedRecordingsSheet(
  BuildContext context, {
  required List<PrerecordedRecordingItem> recordings,
  PrerecordedRecordingItem? selected,
}) {
  return showAppBottomSheet<PrerecordedRecordingItem>(
    context,
    showHeaderDivider: false,
    padding: EdgeInsets.zero,
    body: _PrerecordedRecordingsSheet(
      recordings: recordings,
      selected: selected,
    ),
  );
}

class _PrerecordedRecordingsSheet extends StatelessWidget {
  const _PrerecordedRecordingsSheet({
    required this.recordings,
    required this.selected,
  });

  final List<PrerecordedRecordingItem> recordings;
  final PrerecordedRecordingItem? selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing2xl,
            vertical: AppDimensions.spacingVerticalLg,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Select recordings',
                  style: typography.h3.copyWith(color: theme.textPrimary),
                ),
              ),
              TextButton(
                onPressed: () => moveBack(context),
                child: Text(
                  'Cancel',
                  style: typography.label.copyWith(color: theme.brandPrimary),
                ),
              ),
            ],
          ),
        ),
        Divider(color: theme.borderDefault, height: 1),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing2xl),
          itemCount: recordings.length,
          separatorBuilder: (_, __) =>
              Divider(color: theme.borderDefault, height: 1),
          itemBuilder: (context, index) {
            final item = recordings[index];
            final isSelected = item.id == selected?.id;
            return InkWell(
              onTap: () => moveBack(context, item),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.spacingVerticalLg,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: theme.backgroundInput,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusSm),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: theme.textSecondary,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: AppDimensions.spacingMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: typography.bodyMedium.copyWith(
                              color: theme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppDimensions.spacingVerticalXs),
                          Text(
                            item.meta,
                            style: typography.captionLight.copyWith(
                              color: theme.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_rounded,
                        color: theme.brandPrimary,
                        size: 20.sp,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: AppDimensions.spacingVerticalLg),
      ],
    );
  }
}
