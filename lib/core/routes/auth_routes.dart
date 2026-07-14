import 'package:aidm/core/result/result.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/utils/app/app_logger.dart';
import 'package:aidm/feature/auth/domain/entities/auth_resume_route.dart';
import 'package:aidm/feature/auth/domain/entities/user_session.dart';
import 'package:aidm/feature/auth/domain/entities/verify_otp_result.dart';
import 'package:aidm/feature/auth/domain/repositories/auth_repository.dart';
import 'package:aidm/feature/auth/domain/usecases/enter_app.dart';
import 'package:aidm/feature/auth/presentation/bloc/session/session_bloc.dart';
import 'package:aidm/feature/auth/presentation/bloc/session/session_event.dart';
import 'package:aidm/feature/auth/presentation/pages/otp_verification_page.dart';
import 'package:aidm/feature/auth/presentation/pages/permission_page.dart';
import 'package:aidm/feature/auth/presentation/pages/premium_page.dart';
import 'package:aidm/feature/auth/presentation/pages/sign_in_page.dart';
import 'package:aidm/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract final class AuthRoutes {
  static Future<void> toSignUp(BuildContext context) {
    return moveTo(context, const SignUpPage());
  }

  static Future<void> toSignIn(BuildContext context) {
    return moveTo(context, const SignInPage(), replace: true);
  }

  static Future<void> toSignUpFromSignIn(BuildContext context) {
    return moveTo(context, const SignUpPage(), replace: true);
  }

  static Future<void> toOtpVerification(
    BuildContext context, {
    required String email,
  }) {
    return moveTo(context, OtpVerificationPage(email: email));
  }

  static Future<void> backFromSignUp(BuildContext context) {
    return maybeMoveBack(context);
  }

  static Future<void> backFromSignIn(BuildContext context) {
    return maybeMoveBack(context);
  }

  static Future<void> backFromOtpVerification(BuildContext context) {
    return maybeMoveBack(context);
  }

  static Future<void> toPermission(BuildContext context) {
    return moveTo(context, const PermissionPage());
  }

  static Future<void> toPremium(
    BuildContext context, {
    String? email,
  }) {
    return moveTo(context, PremiumPage(email: email));
  }

  /// Switches to the dashboard via [SessionBloc] — no [moveTo] to [AppShell].
  static void signIn(BuildContext context, UserSession session) {
    context.read<SessionBloc>().add(SessionSignedIn(session));
  }

  static Future<void> navigateAfterVerifyOtp(
    BuildContext context,
    VerifyOtpResult result,
  ) async {
    final repository = context.read<AuthRepository>();
    final cached = await _readCachedSession(repository, result.email);

    if (result.isNewUser) {
      AppLogger.auth('post-verify route → PermissionPage (new user)');
      await repository.saveSessionMetadata(
        cached.copyWith(
          email: result.email,
          displayName: result.displayName ?? cached.displayName,
          avatarUrl: result.avatarUrl ?? cached.avatarUrl,
          isNewUser: true,
          isPremium: false,
          isPermissionComplete: false,
          resumeRoute: AuthResumeRoute.permission,
        ),
      );
      if (!context.mounted) return;
      await toPermission(context);
      return;
    }

    if (result.isPremium) {
      AppLogger.auth('post-verify route → Dashboard (premium user)');
      await repository.saveSessionMetadata(
        cached.copyWith(
          email: result.email,
          displayName: result.displayName ?? cached.displayName,
          avatarUrl: result.avatarUrl ?? cached.avatarUrl,
          isPremium: true,
          isNewUser: false,
          isPermissionComplete: true,
          resumeRoute: AuthResumeRoute.welcome,
          permissionPageIndex: 0,
        ),
      );
      if (!context.mounted) return;

      final enterResult = await EnterApp(repository)(
        EnterAppParams(email: result.email),
      );
      if (!context.mounted) return;

      enterResult.fold(
        onSuccess: (session) {
          signIn(context, session.copyWith(isPremium: true));
        },
        onFailure: (_) {
          signIn(
            context,
            cached.copyWith(
              email: result.email,
              displayName: result.displayName ?? cached.displayName,
              avatarUrl: result.avatarUrl ?? cached.avatarUrl,
              isPremium: true,
              isPermissionComplete: true,
              resumeRoute: AuthResumeRoute.welcome,
              permissionPageIndex: 0,
            ),
          );
        },
      );
      return;
    }

    AppLogger.auth('post-verify route → PremiumPage (non-premium user)');
    await repository.saveSessionMetadata(
      cached.copyWith(
        email: result.email,
        displayName: result.displayName ?? cached.displayName,
        avatarUrl: result.avatarUrl ?? cached.avatarUrl,
        isPremium: false,
        isNewUser: false,
        isPermissionComplete: false,
        resumeRoute: AuthResumeRoute.subscription,
      ),
    );
    if (!context.mounted) return;
    await toPremium(context, email: result.email);
  }

  static Future<UserSession> _readCachedSession(
    AuthRepository repository,
    String email,
  ) async {
    final result = await repository.readCachedSession();
    return result.fold(
      onSuccess: (session) => session ?? UserSession(email: email),
      onFailure: (_) => UserSession(email: email),
    );
  }
}
