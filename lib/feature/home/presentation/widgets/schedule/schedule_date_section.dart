import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduleDateSection extends StatelessWidget {
  const ScheduleDateSection({
    super.key,
    required this.startDateLabel,
    required this.startTimeLabel,
    required this.endDateLabel,
    required this.endTimeLabel,
    required this.isStartDateActive,
    required this.isStartTimeActive,
    required this.isEndDateActive,
    required this.isEndTimeActive,
    required this.showStartPicker,
    required this.showEndPicker,
    required this.onStartDateTap,
    required this.onStartTimeTap,
    required this.onEndDateTap,
    required this.onEndTimeTap,
    required this.picker,
  });

  final String startDateLabel;
  final String startTimeLabel;
  final String endDateLabel;
  final String endTimeLabel;

  final bool isStartDateActive;
  final bool isStartTimeActive;
  final bool isEndDateActive;
  final bool isEndTimeActive;

  final bool showStartPicker;
  final bool showEndPicker;

  final VoidCallback onStartDateTap;
  final VoidCallback onStartTimeTap;
  final VoidCallback onEndDateTap;
  final VoidCallback onEndTimeTap;

  /// The inline picker widget to display under Start/End.
  /// The parent decides which picker to render based on state.
  final Widget picker;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Start',
          style: typography.bodyMedium.copyWith(color: theme.textSecondary),
        ),
        SizedBox(height: AppDimensions.spacingSm),
        Row(
          children: [
            Expanded(
              child: _DateTimeField(
                iconAsset: AppAssets.calendar2Icon,
                value: startDateLabel,
                isActive: isStartDateActive,
                onTap: onStartDateTap,
              ),
            ),
            SizedBox(width: AppDimensions.spacingMd),
            Expanded(
              child: _DateTimeField(
                iconAsset: AppAssets.alarmIcon,
                value: startTimeLabel,
                isActive: isStartTimeActive,
                onTap: onStartTimeTap,
              ),
            ),
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: showStartPicker
              ? Padding(
                  key: const ValueKey('start-picker'),
                  padding: EdgeInsets.only(top: AppDimensions.spacingLg),
                  child: picker,
                )
              : const SizedBox.shrink(key: ValueKey('start-empty')),
        ),
        SizedBox(height: AppDimensions.spacingVertical2xl),
        Text(
          'End',
          style: typography.bodyMedium.copyWith(color: theme.textSecondary),
        ),
        SizedBox(height: AppDimensions.spacingSm),
        Row(
          children: [
            Expanded(
              child: _DateTimeField(
                iconAsset: AppAssets.calendar2Icon,
                value: endDateLabel,
                isActive: isEndDateActive,
                onTap: onEndDateTap,
              ),
            ),
            SizedBox(width: AppDimensions.spacingMd),
            Expanded(
              child: _DateTimeField(
                iconAsset: AppAssets.alarmIcon,
                value: endTimeLabel,
                isActive: isEndTimeActive,
                onTap: onEndTimeTap,
              ),
            ),
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: showEndPicker
              ? Padding(
                  key: const ValueKey('end-picker'),
                  padding: EdgeInsets.only(top: AppDimensions.spacingLg),
                  child: picker,
                )
              : const SizedBox.shrink(key: ValueKey('end-empty')),
        ),
      ],
    );
  }
}

class _DateTimeField extends StatelessWidget {
  const _DateTimeField({
    required this.iconAsset,
    required this.value,
    required this.isActive,
    required this.onTap,
  });

  final String iconAsset;
  final String value;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    final borderColor = isActive ? theme.borderFocus : theme.borderDefault;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        splashColor: theme.brandPrimary.withValues(alpha: 0.08),
        highlightColor: theme.brandPrimary.withValues(alpha: 0.04),
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingMd,
            vertical: 11.h,
          ),
          decoration: BoxDecoration(
            color: theme.backgroundPage,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                iconAsset,
                width: AppDimensions.iconSizehMd,
                colorFilter: ColorFilter.mode(
                  theme.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: AppDimensions.spacingSm),
              Expanded(
                child: Text(
                  value,
                  style: typography.bodyMedium.copyWith(
                    color: theme.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
