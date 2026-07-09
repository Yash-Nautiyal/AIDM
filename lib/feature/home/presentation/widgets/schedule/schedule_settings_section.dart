import 'package:aidm/core/constant/app_animations.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/feature/home/presentation/widgets/sheets/start/start_sheet_setting_row.dart';
import 'package:flutter/material.dart';

class ScheduleSettingsSection extends StatefulWidget {
  const ScheduleSettingsSection({
    super.key,
    required this.timeZoneLabel,
    required this.repeatValue,
    required this.repeatOptions,
    this.onTimeZoneTap,
    this.onRepeatChanged,
    this.onAdvancedTap,
  });

  final String timeZoneLabel;
  final String repeatValue;
  final List<String> repeatOptions;

  final VoidCallback? onTimeZoneTap;
  final ValueChanged<String>? onRepeatChanged;
  final VoidCallback? onAdvancedTap;

  @override
  State<ScheduleSettingsSection> createState() =>
      _ScheduleSettingsSectionState();
}

class _ScheduleSettingsSectionState extends State<ScheduleSettingsSection> {
  bool _isRepeatExpanded = false;

  void _toggleRepeatExpanded() {
    setState(() => _isRepeatExpanded = !_isRepeatExpanded);
  }

  void _selectRepeat(String value) {
    widget.onRepeatChanged?.call(value);
    setState(() => _isRepeatExpanded = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.borderDefault),
        borderRadius: BorderRadius.circular(AppDimensions.spacing2xl),
      ),
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
      child: Column(
        children: [
          StartSheetSettingsRow(
            title: 'Time Zone',
            subtitle: '',
            onTap: widget.onTimeZoneTap,
            trailing: _TimeZoneSettingsTrailing(value: widget.timeZoneLabel),
          ),
          Divider(color: theme.borderDefault, height: 1),
          StartSheetSettingsRow(
            title: 'Repeat',
            subtitle: '',
            onTap: _toggleRepeatExpanded,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.repeatValue,
                  style: typography.body.copyWith(color: theme.textSecondary),
                ),
                SizedBox(width: AppDimensions.spacingSm),
                AppAnimations.expandChevron(
                  isExpanded: _isRepeatExpanded,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: theme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          AppAnimations.expandCollapse(
            isExpanded: _isRepeatExpanded,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(color: theme.borderDefault, height: 1),
                _RepeatDropdown(
                  options: widget.repeatOptions,
                  selected: widget.repeatValue,
                  onSelected: _selectRepeat,
                ),
              ],
            ),
          ),
          Divider(color: theme.borderDefault, height: 1),
          StartSheetSettingsRow(
            title: 'Advanced Settings',
            subtitle: '',
            onTap: widget.onAdvancedTap,
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: theme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _RepeatDropdown extends StatelessWidget {
  const _RepeatDropdown({
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      children: List.generate(options.length, (index) {
        final value = options[index];
        final isSelected = value == selected;
        return Column(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onSelected(value),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.spacingVerticalLg,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 28,
                        child: isSelected
                            ? Icon(
                                Icons.check_rounded,
                                color: theme.brandPrimary,
                                size: 18,
                              )
                            : const SizedBox.shrink(),
                      ),
                      Expanded(
                        child: Text(
                          value,
                          style: typography.bodyMedium.copyWith(
                            color: isSelected
                                ? theme.brandPrimary
                                : theme.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (index != options.length - 1)
              Divider(color: theme.borderDefault, height: 1),
          ],
        );
      }),
    );
  }
}

class _TimeZoneSettingsTrailing extends StatelessWidget {
  const _TimeZoneSettingsTrailing({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: typography.body.copyWith(color: theme.textSecondary),
        ),
        SizedBox(width: AppDimensions.spacingSm),
        Icon(Icons.chevron_right_rounded, color: theme.textSecondary),
      ],
    );
  }
}
