import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:flutter/material.dart';

enum PrerecordedVideoSource { recordings, upload }

class PrerecordedVideoSourceSegment extends StatelessWidget {
  const PrerecordedVideoSourceSegment({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final PrerecordedVideoSource value;
  final ValueChanged<PrerecordedVideoSource> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SegmentButton(
            label: 'Recordings',
            isSelected: value == PrerecordedVideoSource.recordings,
            onTap: () => onChanged(PrerecordedVideoSource.recordings),
          ),
        ),
        SizedBox(width: AppDimensions.spacingSm),
        Expanded(
          child: _SegmentButton(
            label: 'Upload',
            isSelected: value == PrerecordedVideoSource.upload,
            onTap: () => onChanged(PrerecordedVideoSource.upload),
          ),
        ),
      ],
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? theme.brandPrimary : theme.backgroundInput,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          ),
          child: Center(
            child: Text(
              label,
              style: typography.bodyMedium.copyWith(
                color: isSelected ? theme.brandPrimaryTint : theme.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
