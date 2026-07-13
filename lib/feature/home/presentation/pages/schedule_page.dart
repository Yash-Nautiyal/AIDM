import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:aidm/core/widgets/datepicker/app_date_picker.dart';
import 'package:aidm/core/widgets/datepicker/app_time_picker.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/date_time_utils.dart';
import 'schedule_advanced_settings_page.dart';
import 'schedule_time_zone_page.dart';
import '../widgets/schedule/schedule_date_section.dart';
import '../widgets/schedule/schedule_footer.dart';
import '../widgets/schedule/schedule_settings_section.dart';
import '../widgets/schedule/schedule_title_section.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

enum _ActiveField { none, startDate, startTime, endDate, endTime }

class _SchedulePageState extends State<SchedulePage> {
  final _titleController = TextEditingController();

  late DateTime _startDate;
  late TimeOfDay _startTime;
  late DateTime _endDate;
  late TimeOfDay _endTime;

  String _timeZoneValue = 'Asia/Calcutta';
  String _repeatValue = 'Never';

  _ActiveField _activeField = _ActiveField.none;

  DateTime? _draftDate;
  TimeOfDay? _draftTime;

  @override
  void initState() {
    super.initState();
    final range = DateTimeUtils.defaultScheduleRange();
    _startDate = range.startDate;
    _startTime = range.startTime;
    _endDate = range.endDate;
    _endTime = range.endTime;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _ensureEndAfterStart() {
    final fixed = DateTimeUtils.ensureEndAfterStart(
      startDate: _startDate,
      startTime: _startTime,
      endDate: _endDate,
      endTime: _endTime,
    );
    _endDate = fixed.date;
    _endTime = fixed.time;
  }

  void _openStartDate() => setState(() {
    _activeField = _ActiveField.startDate;
    _draftDate = _startDate;
    _draftTime = null;
  });

  void _openStartTime() => setState(() {
    _activeField = _ActiveField.startTime;
    _draftTime = _startTime;
    _draftDate = null;
  });

  void _openEndDate() => setState(() {
    _activeField = _ActiveField.endDate;
    _draftDate = _endDate;
    _draftTime = null;
  });

  void _openEndTime() => setState(() {
    _activeField = _ActiveField.endTime;
    _draftTime = _endTime;
    _draftDate = null;
  });

  void _closePicker() => setState(() {
    _activeField = _ActiveField.none;
    _draftDate = null;
    _draftTime = null;
  });

  void _applyDraft() {
    setState(() {
      switch (_activeField) {
        case _ActiveField.startDate:
          if (_draftDate != null) {
            _startDate = DateTimeUtils.dateOnly(_draftDate!);
            _ensureEndAfterStart();
          }
          break;
        case _ActiveField.endDate:
          if (_draftDate != null) {
            _endDate = DateTimeUtils.dateOnly(_draftDate!);
            _ensureEndAfterStart();
          }
          break;
        case _ActiveField.startTime:
          if (_draftTime != null) {
            _startTime = _draftTime!;
            _ensureEndAfterStart();
          }
          break;
        case _ActiveField.endTime:
          if (_draftTime != null) {
            _endTime = _draftTime!;
            _ensureEndAfterStart();
          }
          break;
        case _ActiveField.none:
          break;
      }
      _activeField = _ActiveField.none;
      _draftDate = null;
      _draftTime = null;
    });
  }

  Widget _inlinePicker() {
    switch (_activeField) {
      case _ActiveField.startDate:
      case _ActiveField.endDate:
        final initial =
            _draftDate ??
            (_activeField == _ActiveField.startDate ? _startDate : _endDate);
        return AppDatePicker(
          transparent: true,
          showShadow: false,
          initialDate: initial,
          onDateChanged: (d) => setState(() => _draftDate = d),
          onClear: _closePicker,
          onDone: _applyDraft,
        );
      case _ActiveField.startTime:
      case _ActiveField.endTime:
        final initial =
            _draftTime ??
            (_activeField == _ActiveField.startTime ? _startTime : _endTime);
        return AppTimePicker(
          transparent: true,
          showShadow: false,
          initialTime: initial,
          onTimeChanged: (t) => setState(() => _draftTime = t),
          onClear: _closePicker,
          onDone: _applyDraft,
        );
      case _ActiveField.none:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    final repeatOptions = DateTimeUtils.repeatOptions(
      startDate: _startDate,
      startTime: _startTime,
    );

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'New Webinar', showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ScheduleTitleSection(controller: _titleController),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              ScheduleDateSection(
                startDateLabel: DateTimeUtils.formatDate(_startDate),
                startTimeLabel: DateTimeUtils.formatTime(_startTime),
                endDateLabel: DateTimeUtils.formatDate(_endDate),
                endTimeLabel: DateTimeUtils.formatTime(_endTime),
                isStartDateActive: _activeField == _ActiveField.startDate,
                isStartTimeActive: _activeField == _ActiveField.startTime,
                isEndDateActive: _activeField == _ActiveField.endDate,
                isEndTimeActive: _activeField == _ActiveField.endTime,
                showStartPicker:
                    _activeField == _ActiveField.startDate ||
                    _activeField == _ActiveField.startTime,
                showEndPicker:
                    _activeField == _ActiveField.endDate ||
                    _activeField == _ActiveField.endTime,
                onStartDateTap: _openStartDate,
                onStartTimeTap: _openStartTime,
                onEndDateTap: _openEndDate,
                onEndTimeTap: _openEndTime,
                picker: _inlinePicker(),
              ),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              ScheduleSettingsSection(
                timeZoneLabel: _timeZoneValue,
                repeatValue: _repeatValue,
                repeatOptions: repeatOptions,
                onRepeatChanged: (v) => setState(() => _repeatValue = v),
                onTimeZoneTap: () async {
                  final result = await moveTo<String>(
                    context,
                    ScheduleTimeZonePage(initialValue: _timeZoneValue),
                  );
                  if (result == null) return;
                  setState(() => _timeZoneValue = result);
                },
                onAdvancedTap: () {
                  moveTo(context, const ScheduleAdvancedSettingsPage());
                },
              ),
              SizedBox(height: AppDimensions.spacingVertical3xl),
              ScheduleFooter(
                onSave: () {},
                onCancel: () => maybeMoveBack(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
