import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../feature/auth/domain/entities/auth_resume_route.dart';
import '../../../feature/auth/domain/repositories/auth_repository.dart';
import '../../../feature/auth/domain/usecases/request_otp.dart';
import '../../../feature/auth/presentation/bloc/request_otp/request_otp_cubit.dart';
import '../../../feature/auth/presentation/bloc/session/session_bloc.dart';
import '../../../feature/auth/presentation/bloc/session/session_state.dart';
import '../../../feature/auth/presentation/pages/permission_page.dart';
import '../../../feature/auth/presentation/pages/premium_page.dart';
import '../../../feature/auth/presentation/pages/welocome_page.dart';
import '../../routes/app_router.dart';
import '../../utils/app/app_logger.dart';
import 'app_shell.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionBloc, SessionState>(
      listener: (context, state) {
        final screen = switch (state) {
          SessionInitial() => 'Initial',
          SessionRestoring() => 'Restoring',
          SessionUnauthenticated(:final resumeRoute, :final email) =>
            'Unauthenticated (${resumeRoute.name}, email=${email ?? 'null'})',
          SessionAuthenticated(:final session) =>
            'Authenticated (${session.email})',
        };
        AppLogger.session('AuthGate screen → $screen');
      },
      child: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          return switch (state) {
            SessionInitial() || SessionRestoring() =>
              const _SessionLoadingPage(),
            SessionUnauthenticated(:final resumeRoute, :final email) =>
              _AuthNavigator(resumeRoute: resumeRoute, email: email),
            SessionAuthenticated() => const AppShell(),
          };
        },
      ),
    );
  }
}

class _AuthNavigator extends StatelessWidget {
  const _AuthNavigator({
    this.resumeRoute = AuthResumeRoute.welcome,
    this.email,
  });

  final AuthResumeRoute resumeRoute;
  final String? email;

  Widget _initialPage() {
    return switch (resumeRoute) {
      AuthResumeRoute.permission => const PermissionPage(),
      AuthResumeRoute.subscription => PremiumPage(email: email),
      _ => const WelocomePage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final initialPage = _initialPage();
    final navKey = ValueKey('auth-${resumeRoute.name}-${email ?? ''}');

    return BlocProvider(
      create: (context) => RequestOtpCubit(
        RequestOtp(context.read<AuthRepository>()),
      ),
      child: Navigator(
        key: navKey,
        onGenerateRoute: (settings) => pageRoute(
          page: initialPage,
          settings: settings,
        ),
      ),
    );
  }
}

class _SessionLoadingPage extends StatelessWidget {
  const _SessionLoadingPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
