import 'attachments.dart';

enum WebinarTab { upcoming, past }

enum WebinarStatus { scheduled, live, past, draft }

enum WebinarListAction { startNow, details }

class Webinar {
  const Webinar({
    required this.id,
    required this.title,
    required this.teamAndLocation,
    required this.startAt,
    required this.endAt,
    required this.timeZone,
    required this.status,
    required this.inviteLink,
    required this.code,
    this.waitingRoom = false,
    this.watermark = false,
    this.isPast = false,
    this.canStart = false,
    this.attachments = const [],
  });

  final String id;
  final String title;
  final String teamAndLocation;
  final DateTime startAt;
  final DateTime endAt;
  final String timeZone;
  final WebinarStatus status;
  final String inviteLink;
  final String code;
  final bool waitingRoom;
  final bool watermark;
  final bool isPast;
  final bool canStart;
  final List<WebinarAttachment> attachments;

  Webinar copyWith({
    String? id,
    String? title,
    String? teamAndLocation,
    DateTime? startAt,
    DateTime? endAt,
    String? timeZone,
    WebinarStatus? status,
    String? inviteLink,
    String? code,
    bool? waitingRoom,
    bool? watermark,
    bool? isPast,
    bool? canStart,
    List<WebinarAttachment>? attachments,
  }) {
    return Webinar(
      id: id ?? this.id,
      title: title ?? this.title,
      teamAndLocation: teamAndLocation ?? this.teamAndLocation,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      timeZone: timeZone ?? this.timeZone,
      status: status ?? this.status,
      inviteLink: inviteLink ?? this.inviteLink,
      code: code ?? this.code,
      waitingRoom: waitingRoom ?? this.waitingRoom,
      watermark: watermark ?? this.watermark,
      isPast: isPast ?? this.isPast,
      canStart: canStart ?? this.canStart,
      attachments: attachments ?? this.attachments,
    );
  }
}

sealed class WebinarEditResult {
  const WebinarEditResult();
}

class WebinarEditSaved extends WebinarEditResult {
  const WebinarEditSaved(this.webinar);

  final Webinar webinar;
}

class WebinarEditDeleted extends WebinarEditResult {
  const WebinarEditDeleted(this.id);

  final String id;
}
