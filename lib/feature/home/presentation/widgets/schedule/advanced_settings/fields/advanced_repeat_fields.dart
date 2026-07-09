import 'package:aidm/core/constant/app_animations.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/bottom_sheet/app_bottom_options.dart';
import 'package:flutter/material.dart';

import '../repeat/repeat_numerical_field.dart';
import '../repeat/repeat_select_field.dart';

class ScheduleAdvancedRepeatFields extends StatefulWidget {
  const ScheduleAdvancedRepeatFields({
    super.key,
    required this.frequency,
    required this.interval,
    required this.ends,
    required this.occurrences,
    required this.onFrequencyChanged,
    required this.onIntervalChanged,
    required this.onEndsChanged,
    required this.onOccurrencesChanged,
  });

  final String frequency;
  final int interval;
  final String ends;
  final int occurrences;

  final ValueChanged<String> onFrequencyChanged;
  final ValueChanged<int> onIntervalChanged;
  final ValueChanged<String> onEndsChanged;
  final ValueChanged<int> onOccurrencesChanged;

  static const frequencyOptions = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  static const endsOptions = ['After N times'];

  @override
  State<ScheduleAdvancedRepeatFields> createState() =>
      _ScheduleAdvancedRepeatFieldsState();
}

class _ScheduleAdvancedRepeatFieldsState
    extends State<ScheduleAdvancedRepeatFields> {
  _RepeatSelectField? _expandedField;

  late final TextEditingController _intervalController;
  late final TextEditingController _occurrencesController;

  @override
  void initState() {
    super.initState();
    _intervalController = TextEditingController(text: '${widget.interval}');
    _occurrencesController = TextEditingController(
      text: '${widget.occurrences}',
    );
  }

  @override
  void didUpdateWidget(covariant ScheduleAdvancedRepeatFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.interval != widget.interval &&
        _intervalController.text != '${widget.interval}') {
      _intervalController.text = '${widget.interval}';
    }
    if (oldWidget.occurrences != widget.occurrences &&
        _occurrencesController.text != '${widget.occurrences}') {
      _occurrencesController.text = '${widget.occurrences}';
    }
  }

  @override
  void dispose() {
    _intervalController.dispose();
    _occurrencesController.dispose();
    super.dispose();
  }

  void _toggleField(_RepeatSelectField field) {
    setState(() {
      _expandedField = _expandedField == field ? null : field;
    });
  }

  Future<void> _openFrequencySheet() async {
    final result = await showAppBottomSheetOptions(
      context,
      options: ScheduleAdvancedRepeatFields.frequencyOptions,
      selected: widget.frequency,
    );
    if (result == null) return;
    widget.onFrequencyChanged(result);
  }

  void _selectEnds(String value) {
    widget.onEndsChanged(value);
    setState(() => _expandedField = null);
  }

  String get _intervalLabel => switch (widget.frequency) {
    'Weekly' => 'Every week',
    'Monthly' => 'Every month',
    'Yearly' => 'Every year',
    _ => 'Everyday',
  };

  String get _intervalUnit => switch (widget.frequency) {
    'Weekly' => 'Weeks',
    'Monthly' => 'Months',
    'Yearly' => 'Years',
    _ => 'Days',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimensions.spacingLg,
        right: AppDimensions.spacingLg,
        bottom: AppDimensions.spacingVerticalLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabeledSelectField(
            label: 'Frequency',
            value: widget.frequency,
            isExpanded: false,
            onTap: _openFrequencySheet,
          ),
          SizedBox(height: AppDimensions.spacingVerticalMd),
          LabeledNumericField(
            label: _intervalLabel,
            controller: _intervalController,
            suffix: _intervalUnit,
            onChanged: widget.onIntervalChanged,
          ),
          SizedBox(height: AppDimensions.spacingVerticalMd),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LabeledSelectField(
                      label: 'Ends',
                      value: widget.ends,
                      isExpanded: _expandedField == _RepeatSelectField.ends,
                      onTap: () => _toggleField(_RepeatSelectField.ends),
                    ),
                    AppAnimations.expandCollapse(
                      isExpanded: _expandedField == _RepeatSelectField.ends,
                      child: _SelectOptionsList(
                        options: ScheduleAdvancedRepeatFields.endsOptions,
                        selected: widget.ends,
                        onSelected: _selectEnds,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppDimensions.spacingMd),
              Expanded(
                child: LabeledNumericField(
                  label: 'occurrences',
                  controller: _occurrencesController,
                  onChanged: widget.onOccurrencesChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _RepeatSelectField { ends }

class _SelectOptionsList extends StatelessWidget {
  const _SelectOptionsList({
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
                    vertical: AppDimensions.spacingVerticalMd,
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
