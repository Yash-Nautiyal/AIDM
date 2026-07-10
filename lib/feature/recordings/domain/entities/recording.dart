class RecordingChapter {
  const RecordingChapter({
    required this.title,
    required this.startTime,
  });

  final String title;
  final Duration startTime;
}

class Recording {
  const Recording({
    required this.id,
    required this.title,
    required this.teamAndLocation,
    required this.attendedCount,
    required this.date,
    required this.duration,
    required this.isPreRecorded,
    required this.chapters,
  });

  final String id;
  final String title;
  final String teamAndLocation;
  final int attendedCount;
  final DateTime date;
  final Duration duration;
  final bool isPreRecorded;
  final List<RecordingChapter> chapters;
}

enum RecordingFilter { all, preRecorded }

enum RecordingOption { download, share, delete }
