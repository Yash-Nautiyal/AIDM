import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/result/result.dart';
import '../../../../../core/utils/app/app_logger.dart';
import '../../../domain/usecases/request_otp.dart';
import '../../../../../core/utils/auth/auth_utils.dart';
import 'request_otp_state.dart';

class RequestOtpCubit extends Cubit<RequestOtpState> {
  RequestOtpCubit(this._requestOtp) : super(const RequestOtpInitial());

  final RequestOtp _requestOtp;

  Future<void> submit(String email) async {
    final trimmedEmail = email.trim();

    if (trimmedEmail.isEmpty) {
      emit(const RequestOtpFailure(message: 'Please enter your email.'));
      return;
    }

    if (!_isValidEmail(trimmedEmail)) {
      emit(const RequestOtpFailure(message: 'Please enter a valid email address.'));
      return;
    }

    emit(const RequestOtpLoading());
    AppLogger.auth('requestOtp UI: submitting email=$trimmedEmail');

    final result = await _requestOtp(trimmedEmail);

    result.fold(
      onSuccess: (data) {
        AppLogger.auth(
          'requestOtp UI: success → navigate to OTP (isNewUser=${data.isNewUser})',
        );
        emit(
          RequestOtpSuccess(email: data.email, isNewUser: data.isNewUser),
        );
      },
      onFailure: (failure) {
        final message = messageForAuthFailure(failure);
        AppLogger.auth('requestOtp UI: failure → $message');
        emit(RequestOtpFailure(message: message));
      },
    );
  }

  void reset() => emit(const RequestOtpInitial());

  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }
}
