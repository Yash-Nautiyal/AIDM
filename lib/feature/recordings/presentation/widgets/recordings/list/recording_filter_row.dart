import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/widgets/pill/app_pill.dart';
import 'package:aidm/feature/recordings/domain/entities/recording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        _AddButton(onTap: onAddTap),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Material(
      color: theme.brandPrimary,
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: theme.brandPrimary.withValues(alpha: 0.35),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spacingMd),
          child: SvgPicture.asset(
            AppAssets.addIcon,
            width: AppDimensions.iconSizeMd,
            height: AppDimensions.iconSizeMd,
            colorFilter: ColorFilter.mode(
              theme.brandPrimaryTint,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
