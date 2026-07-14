import 'package:aidm/core/utils/common/text_utils.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../../../../core/network/network_client.dart';
import '../../../../core/network/session_cookie_store.dart';
import '../../../../core/result/app_failure.dart';
import '../../../../core/result/result.dart';
import '../../../../core/utils/app/app_logger.dart';
import '../../domain/entities/auth_resume_route.dart';
import '../../domain/entities/otp_request_result.dart';
import '../../domain/entities/user_session.dart';
import '../../domain/entities/verify_otp_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/session_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this._remoteDataSource,
    required this._localDataSource,
    required this._cookieJar,
    required this._sessionCookieStore,
  });

  final AuthRemoteDataSource _remoteDataSource;
  final SessionLocalDataSource _localDataSource;
  final CookieJar _cookieJar;
  final SessionCookieStore _sessionCookieStore;

  @override
  Future<Result<UserSession?>> restoreSession() async {
    try {
      final session = await _localDataSource.readSession();
      final hasCookie = await hasSessionCookie(
        cookieJar: _cookieJar,
        cookieStore: _sessionCookieStore,
      );

      AppLogger.auth(
        'restoreSession: hasCookie=$hasCookie '
        'hasMetadata=${session != null} '
        'complete=${session?.isPermissionComplete}',
      );

      // Prefer local metadata — cookie may arrive later for new users
      // (after create-account on PermissionPage).
      if (session != null && session.isAuthenticated) {
        if (!hasCookie) {
          AppLogger.auth(
            'restoreSession: restoring from prefs without cookie '
            '(API cookie may come after sign-up)',
          );
        }
        return Success(session);
      }

      if (!hasCookie) {
        AppLogger.auth('restoreSession: nothing to restore');
        return const Success(null);
      }

      // Orphan cookie with no metadata — clear stale state.
      AppLogger.auth('restoreSession: cookie without metadata → clearing');
      await _clearStoredSession();
      return const Success(null);
    } catch (error) {
      return _mapError(error);
    }
  }

  @override
  Future<Result<OtpRequestResult>> requestOtp(String email) async {
    try {
      AppLogger.auth('requestOtp: email=$email');
      final response = await _remoteDataSource.requestOtp(email);
      AppLogger.auth('requestOtp: success isNewUser=${response.isNewUser}');

      return Success(response.toEntity());
    } catch (error) {
      return _mapError(error);
    }
  }

  @override
  Future<Result<VerifyOtpResult>> verifyOtp({
    required String email,
    required int otp,
  }) async {
    try {
      AppLogger.auth('verifyOtp: email=$email');
      final response = await _remoteDataSource.verifyOtp(
        email: email,
        otp: otp,
      );
      final entity = response.toEntity();
      AppLogger.auth(
        'verifyOtp: parsed email=${entity.email} '
        'isNewUser=${entity.isNewUser} isPremium=${entity.isPremium} '
        'displayName=${response.displayName ?? 'null'} '
        'avatarUrl=${response.avatarUrl ?? 'null'}',
      );

      await _persistLocal(
        UserSession(
          email: entity.email,
          displayName: response.displayName,
          avatarUrl: response.avatarUrl,
          isPremium: entity.isPremium,
          isNewUser: entity.isNewUser,
          isPermissionComplete: !entity.isNewUser && entity.isPremium,
          resumeRoute: entity.isNewUser
              ? AuthResumeRoute.permission
              : entity.isPremium
              ? AuthResumeRoute.welcome
              : AuthResumeRoute.subscription,
        ),
      );

      if (entity.isNewUser) {
        await _localDataSource.writePendingOtp(otp);
      }

      AppLogger.auth('verifyOtp: local metadata saved (cookie optional)');
      return Success(entity);
    } catch (error) {
      return _mapError(error);
    }
  }

  @override
  Future<Result<OtpRequestResult>> resendOtp(String email) => requestOtp(email);

  @override
  Future<Result<void>> createAccount({
    required String email,
    required int otp,
    required String firstName,
    required String lastName,
  }) async {
    try {
      await _remoteDataSource.createAccount(
        email: email,
        otp: otp,
        firstName: firstName,
        lastName: lastName,
      );
      return const Success(null);
    } catch (error) {
      return _mapError(error);
    }
  }

  @override
  Future<Result<void>> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    try {
      await _remoteDataSource.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
      );

      final existing = await _localDataSource.readSession();
      if (existing != null) {
        await _localDataSource.writeSession(
          existing.copyWith(
            email: email,
            displayName: '$firstName $lastName'.trim(),
          ),
        );
      }

      return const Success(null);
    } catch (error) {
      return _mapError(error);
    }
  }

  @override
  Future<Result<void>> updateAvatar(String filePath) async {
    try {
      await _remoteDataSource.updateAvatar(filePath);
      return const Success(null);
    } catch (error) {
      return _mapError(error);
    }
  }

  @override
  Future<Result<String>> completePermission({
    required String displayName,
    String? avatarFilePath,
  }) async {
    try {
      final session = await _localDataSource.readSession();
      final otp = await _localDataSource.readPendingOtp();
      final trimmedName = displayName.trim();

      if (session == null || session.email.isEmpty) {
        return FailureResult(
          ValidationFailure(
            message: 'Session not found. Please sign in again.',
          ),
        );
      }

      if (otp == null) {
        return FailureResult(
          ValidationFailure(
            message: 'Verification expired. Please sign in again.',
          ),
        );
      }

      if (trimmedName.isEmpty) {
        return FailureResult(
          ValidationFailure(message: 'Please enter a display name.'),
        );
      }

      final (firstName, lastName) = parseDisplayName(trimmedName);

      AppLogger.auth('completePermission: email=${session.email}');
      await _remoteDataSource.createAccount(
        email: session.email,
        otp: otp,
        firstName: firstName,
        lastName: lastName,
      );
      await _localDataSource.clearPendingOtp();

      final hasCookie = await hasSessionCookie(
        cookieJar: _cookieJar,
        cookieStore: _sessionCookieStore,
      );
      AppLogger.auth(
        'completePermission: createAccount done hasCookie=$hasCookie',
      );

      if (avatarFilePath != null && avatarFilePath.isNotEmpty) {
        try {
          await _remoteDataSource.updateAvatar(avatarFilePath);
          AppLogger.auth('completePermission: avatar uploaded');
        } catch (error) {
          AppLogger.auth(
            'completePermission: avatar upload failed (non-fatal) → $error',
          );
        }
      }

      try {
        await _remoteDataSource.updateProfile(
          firstName: firstName,
          lastName: lastName,
          email: session.email,
        );
        AppLogger.auth('completePermission: profile updated');
      } catch (error) {
        AppLogger.auth(
          'completePermission: profile update failed (non-fatal) → $error',
        );
      }

      await _persistLocal(
        UserSession(
          email: session.email,
          displayName: trimmedName,
          isNewUser: false,
          isPremium: false,
          isPermissionComplete: false,
          resumeRoute: AuthResumeRoute.subscription,
          permissionPageIndex: session.permissionPageIndex,
        ),
      );

      AppLogger.auth('completePermission: local metadata saved → subscription');
      return Success(session.email);
    } catch (error) {
      return _mapError(error);
    }
  }

  @override
  Future<Result<void>> signOut() => clearSession();

  @override
  Future<Result<void>> clearSession() async {
    try {
      await _clearStoredSession();
      return const Success(null);
    } catch (error) {
      return _mapError(error);
    }
  }

  @override
  Future<Result<void>> saveSessionMetadata(UserSession session) async {
    try {
      await _persistLocal(session);
      return const Success(null);
    } catch (error) {
      return _mapError(error);
    }
  }

  @override
  Future<Result<UserSession?>> readCachedSession() async {
    try {
      return Success(await _localDataSource.readSession());
    } catch (error) {
      return _mapError(error);
    }
  }

  Future<void> _clearStoredSession() async {
    AppLogger.auth('clearSession: wiping cookie + prefs');
    await _sessionCookieStore.clear();
    await clearSessionCookies(_cookieJar);
    await _localDataSource.clear();
  }

  /// Layer 2 — local UI session metadata (handoff §5).
  /// Always persisted regardless of whether [connect.sid] was returned.
  Future<void> _persistLocal(UserSession session) async {
    final existing = await _localDataSource.readSession();
    final merged = _mergeSession(session, existing);
    await _localDataSource.writeSession(merged);
  }

  UserSession _mergeSession(UserSession incoming, UserSession? existing) {
    if (!incoming.isAuthenticated &&
        incoming.resumeRoute == AuthResumeRoute.welcome) {
      return incoming;
    }

    if (existing == null) return incoming;

    return UserSession(
      email: incoming.email.isNotEmpty ? incoming.email : existing.email,
      displayName: incoming.displayName ?? existing.displayName,
      avatarUrl: incoming.avatarUrl ?? existing.avatarUrl,
      isPremium: incoming.isPremium || existing.isPremium,
      isNewUser: incoming.isNewUser,
      isPermissionComplete:
          incoming.isPermissionComplete || existing.isPermissionComplete,
      resumeRoute: incoming.resumeRoute,
      permissionPageIndex: incoming.permissionPageIndex != 0
          ? incoming.permissionPageIndex
          : existing.permissionPageIndex,
    );
  }

  FailureResult<T> _mapError<T>(Object error) {
    return FailureResult(mapCaughtError(error));
  }
}
