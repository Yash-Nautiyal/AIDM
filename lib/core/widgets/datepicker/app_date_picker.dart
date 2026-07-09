import 'package:flutter/material.dart';

import '../../constant/app_dimensions.dart';
import '../../theme/app_theme_extension.dart';
import '../../theme/typography/app_typography_extension.dart';
import 'app_date_picker_card.dart';
import 'app_date_picker_footer.dart';

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateChanged,
    this.onClear,
    this.onDone,
    this.showFooter = true,
    this.transparent = false,
    this.showShadow = true,
  });

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onDateChanged;
  final VoidCallback? onClear;
  final VoidCallback? onDone;
  final bool showFooter;
  final bool transparent;
  final bool showShadow;

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
  }

  DatePickerThemeData _datePickerTheme(AppThemeExtension theme) {
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    return DatePickerThemeData(
      backgroundColor: Colors.transparent,
      headerForegroundColor: theme.textPrimary,
      headerHeadlineStyle: typography.h3,
      weekdayStyle: typography.body.copyWith(color: theme.textSecondary),
      dayStyle: typography.body.copyWith(color: theme.textPrimary),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return theme.brandPrimaryTint;
        }
        if (states.contains(WidgetState.disabled)) {
          return theme.textTertiary;
        }
        return theme.textPrimary;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return theme.brandPrimary;
        }
        return Colors.transparent;
      }),
      dayShape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        ),
      ),
      todayForegroundColor: WidgetStateProperty.all(theme.brandPrimary),
      todayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return theme.brandPrimaryTint;
        }
        return theme.textPrimary;
      }),
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return theme.brandPrimary;
        }
        return Colors.transparent;
      }),
      dividerColor: theme.borderDefault,
      subHeaderForegroundColor: theme.textSecondary,
    );
  }

  void _handleDateChanged(DateTime date) {
    setState(() => _selectedDate = date);
    widget.onDateChanged?.call(date);
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
    final now = DateTime.now();
    final firstDate = widget.firstDate ?? DateTime(now.year - 100);
    final lastDate = widget.lastDate ?? DateTime(now.year + 100);

    return AppDatePickerCard(
      transparent: widget.transparent,
      showShadow: widget.showShadow,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DatePickerTheme(
            data: _datePickerTheme(theme),
            child: Theme(
              data: Theme.of(context).copyWith(
                textTheme: Theme.of(context).textTheme.copyWith(
                  titleSmall: typography.bodyMedium16.copyWith(
                    color: theme.textPrimary,
                  ),
                ),
              ),
              child: CalendarDatePicker(
                initialDate: _selectedDate,
                firstDate: firstDate,
                lastDate: lastDate,
                currentDate: now,
                onDateChanged: _handleDateChanged,
              ),
            ),
          ),
          if (widget.showFooter)
            AppDatePickerFooter(onClear: _handleClear, onDone: _handleDone),
        ],
      ),
    );
  }
}
