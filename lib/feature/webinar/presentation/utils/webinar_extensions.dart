import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/feature/webinar/domain/entities/webinar.dart';
import 'package:flutter/material.dart';

extension WebinarX on Webinar {
  Duration get duration => endAt.difference(startAt);

  String get timeRangeLabel {
    final start = _formatTime(startAt);
    final end = _formatTime(endAt);
    return '$start - $end';
  }

  String get dateTimeLabel {
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

    final weekday = weekdays[startAt.weekday] ?? '';
    final month = months[startAt.month] ?? '';
    final startTime = _formatTime(startAt);
    final endTime = _formatTime(endAt);
    return '$weekday, $month ${startAt.day} · $startTime – $endTime';
  }

  String get durationLabel {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0 && minutes > 0) return '$hours hour $minutes mins';
    if (hours > 0) return hours == 1 ? '1 hour' : '$hours hours';
    return '$minutes mins';
  }

  String get timeZoneDurationLabel => '$timeZone · $durationLabel';

  String get statusBadgeLabel => switch (status) {
    WebinarStatus.scheduled => 'Scheduled',
    WebinarStatus.live => 'Live',
    WebinarStatus.past => 'Past',
    WebinarStatus.draft => 'Draft',
  };

  String countdownLabel({DateTime? now}) {
    final current = now ?? DateTime.now();
    if (isPast || endAt.isBefore(current)) return 'Ended';
    if (startAt.isBefore(current) && endAt.isAfter(current)) return 'Live now';

    final diff = startAt.difference(current);
    if (diff.inMinutes < 60) {
      final mins = diff.inMinutes.clamp(1, 59);
      return 'In ${mins}Mins';
    }
    if (diff.inHours < 24) {
      return 'In ${diff.inHours}Hrs';
    }
    return 'In ${diff.inDays}Days';
  }

  Color countdownColor(AppThemeExtension theme) {
    if (isPast || status == WebinarStatus.past) return theme.textSecondary;
    if (status == WebinarStatus.live) return theme.statusLive;
    return theme.statusDraft;
  }

  WebinarListAction get listAction {
    if (!isPast && canStart) return WebinarListAction.startNow;
    return WebinarListAction.details;
  }

  String get listTimeRangeLabel {
    final startHour = startAt.hour;
    final startMinute = startAt.minute.toString().padLeft(2, '0');
    final startHour12 =
        startHour == 0 ? 12 : (startHour > 12 ? startHour - 12 : startHour);
    final end = _formatClock(endAt, includePeriod: true);
    return '$startHour12:$startMinute - $end';
  }

  static String _formatTime(DateTime dateTime) {
    return _formatClock(dateTime, includePeriod: true, spacedPeriod: true);
  }

  static String _formatClock(
    DateTime dateTime, {
    bool includePeriod = false,
    bool spacedPeriod = false,
  }) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final clock = '$hour12:$minute';
    if (!includePeriod) return clock;
    return spacedPeriod ? '$clock $period' : '$clock$period';
  }
}
