import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:aidm/feature/recordings/domain/entities/recording.dart';
import 'package:aidm/feature/recordings/presentation/utils/recording_extensions.dart';
import 'package:flutter/material.dart';

class RecordingOverviewSection extends StatelessWidget {
  const RecordingOverviewSection({
    super.key,
    required this.chapters,
    required this.activeChapterIndex,
    required this.onChapterTap,
  });

  final List<RecordingChapter> chapters;
  final int activeChapterIndex;
  final ValueChanged<int> onChapterTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.pagePadding),
          child: Text(
            'Overview',
            style: typography.label.copyWith(color: theme.brandPrimary),
          ),
        ),
        SizedBox(height: AppDimensions.spacingVerticalSm),
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: chapters.length,
          separatorBuilder: (_, _) =>
              Divider(height: 1, thickness: 1, color: theme.borderDefault),
          itemBuilder: (context, index) {
            final chapter = chapters[index];
            final isActive = index == activeChapterIndex;

            return InkWell(
              onTap: () => onChapterTap(index),
              child: Row(
                children: [
                  Container(
                    width: 5.sp,
                    height: 50.h,
                    margin: EdgeInsets.only(right: AppDimensions.spacingMd),
                    color: isActive ? theme.brandPrimary : Colors.transparent,
                  ),
                  Expanded(
                    child: Text(
                      chapter.title,
                      style: typography.bodyMedium.copyWith(
                        color: isActive
                            ? theme.textPrimary
                            : theme.textSecondary,
                        fontWeight: isActive
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    chapter.startTime.playerTimestampLabel,
                    style: typography.captionLight.copyWith(
                      color: theme.textSecondary,
                    ),
                  ),
                  SizedBox(width: AppDimensions.spacingMd),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
