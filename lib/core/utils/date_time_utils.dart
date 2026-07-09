abstract class DateTimeUtils {
  static DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
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
