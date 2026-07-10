import '../../domain/entities/notification.dart';

extension NotificationSystemMessageX on NotificationTileSystemMessage {
  String get toSystemMessageText {
    switch (this) {
      case NotificationTileSystemMessage.participantLeft:
        return 'left';
      case NotificationTileSystemMessage.participantJoined:
        return 'joined';
      case NotificationTileSystemMessage.participantKicked:
        return 'was removed';
      case NotificationTileSystemMessage.participantBanned:
        return 'was banned';
      case NotificationTileSystemMessage.participantUnbanned:
        return 'was unbanned';
    }
  }
}
