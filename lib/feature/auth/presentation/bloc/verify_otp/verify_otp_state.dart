import 'package:equatable/equatable.dart';

import '../../../domain/entities/verify_otp_result.dart';

sealed class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object?> get props => [];
}

final class VerifyOtpInitial extends VerifyOtpState {
  const VerifyOtpInitial();
}

final class VerifyOtpVerifying extends VerifyOtpState {
  const VerifyOtpVerifying();
}

final class VerifyOtpResending extends VerifyOtpState {
  const VerifyOtpResending();
}

final class VerifyOtpSuccess extends VerifyOtpState {
  const VerifyOtpSuccess(this.result);

  final VerifyOtpResult result;

  @override
  List<Object?> get props => [result];
}

final class VerifyOtpFailure extends VerifyOtpState {
  const VerifyOtpFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

final class VerifyOtpResent extends VerifyOtpState {
  const VerifyOtpResent();
}
