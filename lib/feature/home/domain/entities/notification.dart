import 'dart:ui';

enum NotificationTileType { comment, system, attachment, event }

enum NotificationTileSystemMessage {
  participantLeft,
  participantJoined,
  participantKicked,
  participantBanned,
  participantUnbanned,
}

class NotificationSectionData {
  const NotificationSectionData({required this.title, required this.items});

  final String title;
  final List<NotificationTileData> items;
}

class NotificationTileData {
  const NotificationTileData({
    required this.type,
    required this.avatarColor,
    required this.timestamp,
    this.author,
    this.comment,
    this.systemMessage,
    this.attachment,
    this.eventTitle,
    this.eventActor,
    this.eventAction,
    this.calendarDay,
  });

  final NotificationTileType type;
  final Color avatarColor;
  final String timestamp;
  final String? author;
  final String? comment;
  final NotificationTileSystemMessage? systemMessage;
  final String? attachment;
  final String? eventTitle;
  final String? eventActor;
  final String? eventAction;
  final int? calendarDay;
}
