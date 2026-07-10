extension RecordingDateTimeX on DateTime {
  String get recordingDateLabel {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[month - 1]} $day, $year';
  }
}

extension RecordingDurationX on Duration {
  String get recordingDurationLabel {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  String get playerTimestampLabel {
    final minutes = inMinutes;
    final seconds = inSeconds.remainder(60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
