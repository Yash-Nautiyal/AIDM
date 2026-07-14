import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:aidm/feature/recordings/presentation/utils/recording_extensions.dart';
import 'package:flutter/material.dart';

class RecordingThumbnail extends StatelessWidget {
  const RecordingThumbnail({super.key, required this.duration, this.onTap});

  final Duration duration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 98.w,
        height: 70.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          child: Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(gradient: theme.gradientBrandPurple),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(2.sp),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),
              Positioned(
                left: AppDimensions.spacingXs,
                bottom: AppDimensions.spacingXs,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingXs,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                  ),
                  child: Text(
                    duration.recordingDurationLabel,
                    style: typography.captionBold.copyWith(
                      color: Colors.white,
                      fontSize: 9.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
