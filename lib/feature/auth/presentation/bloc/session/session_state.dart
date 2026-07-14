import 'package:equatable/equatable.dart';

import '../../../domain/entities/auth_resume_route.dart';
import '../../../domain/entities/user_session.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object?> get props => [];
}

final class SessionInitial extends SessionState {
  const SessionInitial();
}

final class SessionRestoring extends SessionState {
  const SessionRestoring();
}

final class SessionUnauthenticated extends SessionState {
  const SessionUnauthenticated({
    this.resumeRoute = AuthResumeRoute.welcome,
    this.email,
  });

  final AuthResumeRoute resumeRoute;
  final String? email;

  @override
  List<Object?> get props => [resumeRoute, email];
}

final class SessionAuthenticated extends SessionState {
  const SessionAuthenticated(this.session);

  final UserSession session;

  @override
  List<Object?> get props => [session];
}

extension SessionStateX on SessionState {
  /// Saved user metadata when authenticated; `null` otherwise.
  UserSession? get sessionOrNull => switch (this) {
    SessionAuthenticated(:final session) => session,
    _ => null,
  };
}
