import '../../../../core/result/app_failure.dart';
import '../../../../core/result/result.dart';
import '../entities/auth_resume_route.dart';
import '../entities/user_session.dart';
import '../repositories/auth_repository.dart';

class EnterAppParams {
  const EnterAppParams({this.email});

  /// Optional email from route args; falls back to cached session email.
  final String? email;
}

/// Builds a [UserSession] ready for dashboard entry (skip subscription / enter app).
class EnterApp {
  const EnterApp(this._repository);

  final AuthRepository _repository;

  Future<Result<UserSession>> call(EnterAppParams params) async {
    final cachedResult = await _repository.readCachedSession();

    return cachedResult.fold(
      onSuccess: (cached) {
        final resolvedEmail = _resolveEmail(params.email, cached?.email);
        if (resolvedEmail == null || resolvedEmail.isEmpty) {
          return FailureResult<UserSession>(
            const ValidationFailure(
              message: 'Session not found. Please sign in again.',
            ),
          );
        }

        final base = cached ?? UserSession(email: resolvedEmail);

        return Success(
          base.copyWith(
            email: resolvedEmail,
            isNewUser: false,
            isPermissionComplete: true,
            resumeRoute: AuthResumeRoute.welcome,
            permissionPageIndex: 0,
          ),
        );
      },
      onFailure: (failure) => FailureResult<UserSession>(failure),
    );
  }

  String? _resolveEmail(String? override, String? cachedEmail) {
    final trimmedOverride = override?.trim();
    if (trimmedOverride != null && trimmedOverride.isNotEmpty) {
      return trimmedOverride;
    }

    final trimmedCached = cachedEmail?.trim();
    if (trimmedCached != null && trimmedCached.isNotEmpty) {
      return trimmedCached;
    }

    return null;
  }
}
