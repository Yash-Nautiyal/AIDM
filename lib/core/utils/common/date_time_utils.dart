import 'package:flutter/material.dart';

abstract class DateTimeUtils {
  static const _monthNames = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static String formatTime(TimeOfDay time) {
    final hour12 = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour12:$minute $period';
  }

  static String formatDate(DateTime date) {
    return '${_monthNames[date.month - 1]} ${date.day}, ${date.year}';
  }

  static DateTime combine(DateTime date, TimeOfDay time) =>
      DateTime(date.year, date.month, date.day, time.hour, time.minute);

  static String weekdayName(DateTime date) => switch (date.weekday) {
    DateTime.monday => 'Monday',
    DateTime.tuesday => 'Tuesday',
    DateTime.wednesday => 'Wednesday',
    DateTime.thursday => 'Thursday',
    DateTime.friday => 'Friday',
    DateTime.saturday => 'Saturday',
    DateTime.sunday => 'Sunday',
    _ => 'Monday',
  };

  static String dayWithSuffix(int day) {
    if (day >= 11 && day <= 13) return '${day}th';
    return switch (day % 10) {
      1 => '${day}st',
      2 => '${day}nd',
      3 => '${day}rd',
      _ => '${day}th',
    };
  }

  static ({
    DateTime startDate,
    TimeOfDay startTime,
    DateTime endDate,
    TimeOfDay endTime,
  }) defaultScheduleRange({
    DateTime? now,
    Duration duration = const Duration(hours: 1),
  }) {
    final current = now ?? DateTime.now();
    final end = current.add(duration);
    return (
      startDate: dateOnly(current),
      startTime: TimeOfDay.fromDateTime(current),
      endDate: dateOnly(end),
      endTime: TimeOfDay.fromDateTime(end),
    );
  }

  static ({DateTime date, TimeOfDay time}) ensureEndAfterStart({
    required DateTime startDate,
    required TimeOfDay startTime,
    required DateTime endDate,
    required TimeOfDay endTime,
    Duration minimumGap = const Duration(hours: 1),
  }) {
    final start = combine(startDate, startTime);
    final end = combine(endDate, endTime);
    if (!end.isBefore(start)) {
      return (date: endDate, time: endTime);
    }

    final fixed = start.add(minimumGap);
    return (date: dateOnly(fixed), time: TimeOfDay.fromDateTime(fixed));
  }

  static List<String> repeatOptions({
    required DateTime startDate,
    required TimeOfDay startTime,
  }) {
    return [
      'Never',
      'Daily at ${formatTime(startTime)}',
      'Weekly on ${weekdayName(startDate)}',
      'Monthly on the ${dayWithSuffix(startDate.day)}',
      'Every weekday (Mon–Fri)',
    ];
  }

  static String formatDateLabel(DateTime date) {
    final today = dateOnly(DateTime.now());
    final isToday = dateOnly(date) == today;

    const weekdays = <int, String>{
      1: 'Mon',
      2: 'Tue',
      3: 'Wed',
      4: 'Thu',
      5: 'Fri',
      6: 'Sat',
      7: 'Sun',
    };
    const months = <int, String>{
      1: 'Jan',
      2: 'Feb',
      3: 'Mar',
      4: 'Apr',
      5: 'May',
      6: 'Jun',
      7: 'Jul',
      8: 'Aug',
      9: 'Sep',
      10: 'Oct',
      11: 'Nov',
      12: 'Dec',
    };

    final weekday = weekdays[date.weekday] ?? '';
    final month = months[date.month] ?? '';
    final day = date.day;

    if (isToday) return 'Today • $weekday, $day $month';
    return '$weekday, $day $month';
  }
}
