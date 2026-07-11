import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/widgets/button/app_circle_button.dart';
import 'package:aidm/core/widgets/pill/app_pill.dart';
import 'package:aidm/feature/recordings/domain/entities/recording.dart';
import 'package:flutter/material.dart';

class RecordingFilterRow extends StatelessWidget {
  const RecordingFilterRow({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onAddTap,
  });

  final RecordingFilter selectedFilter;
  final ValueChanged<RecordingFilter> onFilterChanged;
  final VoidCallback onAddTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppPill(
          label: 'All',
          isSelected: selectedFilter == RecordingFilter.all,
          onTap: () => onFilterChanged(RecordingFilter.all),
        ),
        SizedBox(width: AppDimensions.spacingSm),
        AppPill(
          label: 'Pre recorded',
          isSelected: selectedFilter == RecordingFilter.preRecorded,
          onTap: () => onFilterChanged(RecordingFilter.preRecorded),
        ),
        const Spacer(),
        AppCircleButton(onTap: onAddTap),
      ],
    );
  }
}
