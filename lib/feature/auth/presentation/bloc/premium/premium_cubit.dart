import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/result/result.dart';
import '../../../../../core/utils/app/app_logger.dart';
import '../../../domain/usecases/enter_app.dart';
import '../../../../../core/utils/auth/auth_utils.dart';
import 'premium_state.dart';

/// Handles skip / enter-app today; subscribe & payment APIs can be added here later.
class PremiumCubit extends Cubit<PremiumState> {
  PremiumCubit(this._enterApp) : super(const PremiumInitial());

  final EnterApp _enterApp;

  Future<void> enterApp({String? email}) async {
    emit(const PremiumEntering());
    AppLogger.auth('premium UI: enter app email=${email ?? '(cached)'}');

    final result = await _enterApp(EnterAppParams(email: email));

    result.fold(
      onSuccess: (session) {
        AppLogger.auth(
          'premium UI: ready → SessionSignedIn (email=${session.email})',
        );
        emit(PremiumEnterAppReady(session));
      },
      onFailure: (failure) {
        final message = messageForAuthFailure(failure);
        AppLogger.auth('premium UI: failure → $message');
        emit(PremiumFailure(message: message));
      },
    );
  }

  // Future: subscribe() → emit PremiumSubscribing → payment API → enterApp / SessionSignedIn

  void clearError() {
    if (state is PremiumFailure) {
      emit(const PremiumInitial());
    }
  }
}
