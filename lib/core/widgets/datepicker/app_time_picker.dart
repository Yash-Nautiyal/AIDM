import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/app_dimensions.dart';
import '../../theme/app_theme_extension.dart';
import '../../theme/typography/app_typography_extension.dart';
import 'app_date_picker_card.dart';
import 'app_date_picker_footer.dart';

class AppTimePicker extends StatefulWidget {
  const AppTimePicker({
    super.key,
    this.initialTime,
    this.onTimeChanged,
    this.onClear,
    this.onDone,
    this.showFooter = true,
    this.use24HourFormat = false,
  });

  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay>? onTimeChanged;
  final VoidCallback? onClear;
  final VoidCallback? onDone;
  final bool showFooter;
  final bool use24HourFormat;

  @override
  State<AppTimePicker> createState() => _AppTimePickerState();
}

class _AppTimePickerState extends State<AppTimePicker> {
  static const double _pickerHeight = 180;

  late DateTime _selectedDateTime;
  late bool _isPm;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialTime ?? TimeOfDay.now();
    _selectedDateTime = DateTime(2020, 1, 1, initial.hour, initial.minute);
    _isPm = initial.period == DayPeriod.pm;
  }

  TimeOfDay get _selectedTime => TimeOfDay.fromDateTime(_selectedDateTime);

  void _notifyTimeChanged() {
    widget.onTimeChanged?.call(_selectedTime);
  }

  void _handleDateTimeChanged(DateTime value) {
    setState(() {
      _selectedDateTime = value;
      _isPm = value.hour >= 12;
    });
    _notifyTimeChanged();
  }

  void _handlePeriodChanged(bool isPm) {
    if (_isPm == isPm) return;

    final hour12 = TimeOfDay.fromDateTime(_selectedDateTime).hourOfPeriod;
    final newHour = isPm
        ? (hour12 == 12 ? 12 : hour12 + 12)
        : (hour12 == 12 ? 0 : hour12);

    setState(() {
      _isPm = isPm;
      _selectedDateTime = _selectedDateTime.copyWith(hour: newHour);
    });
    _notifyTimeChanged();
  }

  void _handleClear() {
    widget.onClear?.call();
  }

  void _handleDone() {
    widget.onDone?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final brightness = Theme.of(context).brightness;
    final background = AppDatePickerCard.backgroundColor(theme, brightness);

    return AppDatePickerCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoTheme(
            data: CupertinoThemeData(
              brightness: brightness,
              primaryColor: theme.brandPrimary,
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: typography.labelLarge,
                pickerTextStyle: typography.labelLarge,
              ),
            ),
            child: SizedBox(
              height: _pickerHeight,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                use24hFormat: true,
                initialDateTime: _selectedDateTime,
                onDateTimeChanged: _handleDateTimeChanged,
                backgroundColor: background,
                showTimeSeparator: true,
              ),
            ),
          ),
          if (!widget.use24HourFormat) ...[
            const SizedBox(height: AppDimensions.spacingSm),
            _AmPmSegment(isPm: _isPm, onChanged: _handlePeriodChanged),
            const SizedBox(height: AppDimensions.spacingMd),
          ],
          if (widget.showFooter)
            AppDatePickerFooter(onClear: _handleClear, onDone: _handleDone),
        ],
      ),
    );
  }
}

class _AmPmSegment extends StatelessWidget {
  const _AmPmSegment({required this.isPm, required this.onChanged});

  final bool isPm;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final brightness = Theme.of(context).brightness;
    final inactiveBackground = brightness == Brightness.dark
        ? theme.buttonInactive
        : theme.backgroundInput;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing2xl),
      child: CupertinoTheme(
        data: CupertinoThemeData(
          primaryColor: theme.brandPrimary,
          brightness: brightness,
        ),
        child: CupertinoSlidingSegmentedControl<bool>(
          groupValue: isPm,
          backgroundColor: inactiveBackground,
          thumbColor: theme.brandPrimary,
          padding: const EdgeInsets.all(2),
          children: {
            false: _SegmentLabel(label: 'AM', isSelected: !isPm, theme: theme),
            true: _SegmentLabel(label: 'PM', isSelected: isPm, theme: theme),
          },
          onValueChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      ),
    );
  }
}

class _SegmentLabel extends StatelessWidget {
  const _SegmentLabel({
    required this.label,
    required this.isSelected,
    required this.theme,
  });

  final String label;
  final bool isSelected;
  final AppThemeExtension theme;

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing2xl,
        vertical: AppDimensions.spacingSm,
      ),
      child: Text(
        label,
        style: typography.bodySemibold.copyWith(
          color: isSelected ? theme.brandPrimaryTint : theme.textSecondary,
        ),
      ),
    );
  }
}
