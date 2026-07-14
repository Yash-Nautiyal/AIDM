import 'package:equatable/equatable.dart';

sealed class RequestOtpState extends Equatable {
  const RequestOtpState();

  @override
  List<Object?> get props => [];
}

final class RequestOtpInitial extends RequestOtpState {
  const RequestOtpInitial();
}

final class RequestOtpLoading extends RequestOtpState {
  const RequestOtpLoading();
}

final class RequestOtpSuccess extends RequestOtpState {
  const RequestOtpSuccess({
    required this.email,
    required this.isNewUser,
  });

  final String email;
  final bool isNewUser;

  @override
  List<Object?> get props => [email, isNewUser];
}

final class RequestOtpFailure extends RequestOtpState {
  const RequestOtpFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
