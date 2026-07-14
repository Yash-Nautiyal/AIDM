import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/result/result.dart';
import '../../../../../core/utils/app/app_logger.dart';
import '../../../domain/entities/user_session.dart';
import '../../../domain/entities/auth_resume_route.dart';
import '../../../domain/usecases/clear_session.dart';
import '../../../domain/usecases/restore_session.dart';
import '../../../domain/usecases/save_session_metadata.dart';
import '../../../domain/usecases/sign_out.dart';
import 'session_event.dart';
import 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required this._restoreSession,
    required this._saveSessionMetadata,
    required this._clearSession,
    required this._signOut,
  }) : super(const SessionInitial()) {
    on<SessionRestoreRequested>(_onRestoreRequested);
    on<SessionSignedIn>(_onSignedIn);
    on<SessionProfileUpdated>(_onProfileUpdated);
    on<SessionSignedOut>(_onSignedOut);
  }

  final RestoreSession _restoreSession;
  final SaveSessionMetadata _saveSessionMetadata;
  final ClearSession _clearSession;
  final SignOut _signOut;

  Future<void> _onRestoreRequested(
    SessionRestoreRequested event,
    Emitter<SessionState> emit,
  ) async {
    AppLogger.session('Step: restore session requested');
    emit(const SessionRestoring());

    final result = await _restoreSession();

    switch (result) {
      case Success(:final value):
        await _emitRestoredSession(value, emit);
      case FailureResult():
        AppLogger.session('Step: restore failed → Welcome');
        emit(const SessionUnauthenticated());
    }
  }

  Future<void> _emitRestoredSession(
    UserSession? session,
    Emitter<SessionState> emit,
  ) async {
    if (session == null) {
      AppLogger.session('Step: no saved session → Welcome');
      emit(const SessionUnauthenticated());
      return;
    }

    if (!session.isPermissionComplete &&
        session.resumeRoute.isPreAuthCheckpoint) {
      AppLogger.session(
        'Step: stale pre-auth checkpoint (${session.resumeRoute.name}) → Welcome',
      );
      await _clearSession();
      emit(const SessionUnauthenticated());
      return;
    }

    if (!session.isPremium &&
        session.resumeRoute == AuthResumeRoute.subscription) {
      AppLogger.session(
        'Step: restore → subscription (email=${session.email})',
      );
      emit(
        SessionUnauthenticated(
          resumeRoute: AuthResumeRoute.subscription,
          email: session.email,
        ),
      );
      return;
    }

    if (session.isPermissionComplete) {
      final normalized = _normalizeCompletedSession(session);
      _logAuthenticatedUser(normalized, source: 'restore');
      emit(SessionAuthenticated(normalized));
      return;
    }

    AppLogger.session(
      'Step: incomplete auth flow → resumeRoute=${session.resumeRoute.name}',
    );
    emit(
      SessionUnauthenticated(
        resumeRoute: session.resumeRoute,
        email: session.email,
      ),
    );
  }

  Future<void> _onSignedIn(
    SessionSignedIn event,
    Emitter<SessionState> emit,
  ) async {
    final session = event.session.copyWith(isPermissionComplete: true);
    AppLogger.session(
      'Step: sign in → saving metadata (email=${session.email})',
    );

    await _saveSessionMetadata(session);
    _logAuthenticatedUser(session, source: 'sign-in');
    emit(SessionAuthenticated(session));
  }

  Future<void> _onProfileUpdated(
    SessionProfileUpdated event,
    Emitter<SessionState> emit,
  ) async {
    AppLogger.session(
      'Step: profile updated → saving metadata (email=${event.session.email})',
    );
    await _saveSessionMetadata(event.session);
    _logAuthenticatedUser(event.session, source: 'profile-updated');
    emit(SessionAuthenticated(event.session));
  }

  void _logAuthenticatedUser(UserSession session, {required String source}) {
    AppLogger.session('Login success ($source) → ${session.toDebugString()}');
  }

  UserSession _normalizeCompletedSession(UserSession session) {
    return session.copyWith(
      resumeRoute: AuthResumeRoute.welcome,
      permissionPageIndex: 0,
      isNewUser: false,
    );
  }

  Future<void> _onSignedOut(
    SessionSignedOut event,
    Emitter<SessionState> emit,
  ) async {
    AppLogger.session('Step: sign out requested');
    final result = await _signOut();

    result.fold(
      onSuccess: (_) => AppLogger.session('Step: sign out complete → Welcome'),
      onFailure: (_) => AppLogger.session('Step: sign out failed → Welcome'),
    );
    emit(const SessionUnauthenticated());
  }
}
