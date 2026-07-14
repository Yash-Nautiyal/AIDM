import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/result/result.dart';
import '../../../../../core/utils/app/app_logger.dart';
import '../../../domain/usecases/resend_otp.dart';
import '../../../domain/usecases/verify_otp.dart';
import '../../../../../core/utils/auth/auth_utils.dart';
import 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit({required this._verifyOtp, required this._resendOtp})
    : super(const VerifyOtpInitial());

  final VerifyOtp _verifyOtp;
  final ResendOtp _resendOtp;

  Future<void> verify({required String email, required String otp}) async {
    if (otp.length != 6) {
      emit(const VerifyOtpFailure(message: 'Please enter the 6-digit code.'));
      return;
    }

    final parsedOtp = int.tryParse(otp);
    if (parsedOtp == null) {
      emit(
        const VerifyOtpFailure(
          message: 'Please enter a valid verification code.',
        ),
      );
      return;
    }

    emit(const VerifyOtpVerifying());
    AppLogger.auth('verifyOtp UI: submitting email=$email');

    final result = await _verifyOtp(
      VerifyOtpParams(email: email, otp: parsedOtp),
    );

    result.fold(
      onSuccess: (data) {
        AppLogger.auth(
          'verifyOtp UI: success isNewUser=${data.isNewUser} '
          'isPremium=${data.isPremium}',
        );
        emit(VerifyOtpSuccess(data));
      },
      onFailure: (failure) {
        final message = messageForAuthFailure(failure);
        AppLogger.auth('verifyOtp UI: failure → $message');
        emit(VerifyOtpFailure(message: message));
      },
    );
  }

  Future<void> resend(String email) async {
    emit(const VerifyOtpResending());
    AppLogger.auth('verifyOtp UI: resend requested email=$email');

    final result = await _resendOtp(email);

    result.fold(
      onSuccess: (_) {
        AppLogger.auth('verifyOtp UI: resend success');
        emit(const VerifyOtpResent());
      },
      onFailure: (failure) {
        final message = messageForAuthFailure(failure);
        AppLogger.auth('verifyOtp UI: resend failure → $message');
        emit(VerifyOtpFailure(message: message));
      },
    );
  }

  void clearError() {
    if (state is VerifyOtpFailure) {
      emit(const VerifyOtpInitial());
    }
  }
}
