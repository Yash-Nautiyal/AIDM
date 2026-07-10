import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:aidm/feature/recordings/domain/entities/recording.dart';
import 'package:aidm/feature/recordings/presentation/utils/recording_extensions.dart';
import 'package:flutter/material.dart';

class RecordingPlayerView extends StatelessWidget {
  const RecordingPlayerView({
    super.key,
    required this.recording,
    required this.currentChapterIndex,
    required this.currentPosition,
    required this.isPlaying,
    required this.onBack,
    required this.onTogglePlay,
  });

  final Recording recording;
  final int currentChapterIndex;
  final Duration currentPosition;
  final bool isPlaying;
  final VoidCallback onBack;
  final VoidCallback onTogglePlay;

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final chapterTitle = recording.chapters[currentChapterIndex].title;
    final progress = recording.duration.inSeconds == 0
        ? 0.0
        : currentPosition.inSeconds / recording.duration.inSeconds;

    return ColoredBox(
      color: Colors.black,
      child: SafeArea(
        bottom: false,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: IconButton(
                  onPressed: onTogglePlay,
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 48.sp,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingXs,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: onBack,
                        icon: Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          chapterTitle,
                          style: typography.bodyMedium.copyWith(
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings_rounded,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: AppDimensions.spacingLg,
                right: AppDimensions.spacingLg,
                bottom: AppDimensions.spacingVerticalMd,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: onTogglePlay,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        ),
                        SizedBox(width: AppDimensions.spacingSm),
                        Text(
                          '${currentPosition.playerTimestampLabel} / ${recording.duration.playerTimestampLabel}',
                          style: typography.captionLight.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.volume_up_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: AppDimensions.spacingMd),
                        Icon(
                          Icons.fullscreen_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.spacingVerticalXs),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2.r),
                      child: LinearProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                        minHeight: 3.h,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
