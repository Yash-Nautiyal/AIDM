import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_client.dart';
import 'core/network/session_cookie_store.dart';
import 'core/utils/app/app_logger.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app/app_screen.dart';
import 'core/widgets/layout/auth_gate.dart';
import 'feature/auth/data/datasources/auth_remote_data_source.dart';
import 'feature/auth/data/datasources/session_local_data_source.dart';
import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/domain/repositories/auth_repository.dart';
import 'feature/auth/domain/usecases/clear_session.dart';
import 'feature/auth/domain/usecases/restore_session.dart';
import 'feature/auth/domain/usecases/save_session_metadata.dart';
import 'feature/auth/domain/usecases/sign_out.dart';
import 'feature/auth/presentation/bloc/session/session_bloc.dart';
import 'feature/auth/presentation/bloc/session/session_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.session('App starting…');

  final preferences = await SharedPreferences.getInstance();
  final sessionCookieStore = SessionCookieStore(preferences);
  await sessionCookieStore.init();

  final unauthorizedNotifier = UnauthorizedNotifier();
  final networkBundle = await NetworkClient.create(
    cookieStore: sessionCookieStore,
    onUnauthorized: unauthorizedNotifier.notify,
  );

  final authRepository = AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSource(networkBundle.dio),
    localDataSource: SessionLocalDataSource(preferences),
    cookieJar: networkBundle.cookieJar,
    sessionCookieStore: sessionCookieStore,
  );

  final sessionBloc = SessionBloc(
    restoreSession: RestoreSession(authRepository),
    saveSessionMetadata: SaveSessionMetadata(authRepository),
    clearSession: ClearSession(authRepository),
    signOut: SignOut(authRepository),
  );

  unauthorizedNotifier.onUnauthorized = () {
    sessionBloc.add(const SessionSignedOut());
  };

  sessionBloc.add(const SessionRestoreRequested());
  AppLogger.session('Session restore dispatched');

  runApp(
    AppScreenScope(
      child: RepositoryProvider<AuthRepository>.value(
        value: authRepository,
        child: BlocProvider.value(value: sessionBloc, child: const MyApp()),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AIDM',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AuthGate(),
    );
  }
}
