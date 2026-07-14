import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_session.dart';

sealed class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object?> get props => [];
}

final class SessionRestoreRequested extends SessionEvent {
  const SessionRestoreRequested();
}

final class SessionSignedIn extends SessionEvent {
  const SessionSignedIn(this.session);

  final UserSession session;

  @override
  List<Object?> get props => [session];
}

final class SessionSignedOut extends SessionEvent {
  const SessionSignedOut();
}

final class SessionProfileUpdated extends SessionEvent {
  const SessionProfileUpdated(this.session);

  final UserSession session;

  @override
  List<Object?> get props => [session];
}
