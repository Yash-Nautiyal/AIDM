import '../../../../core/result/result.dart';
import '../entities/otp_request_result.dart';
import '../repositories/auth_repository.dart';

class ResendOtp {
  const ResendOtp(this._repository);

  final AuthRepository _repository;

  Future<Result<OtpRequestResult>> call(String email) =>
      _repository.resendOtp(email);
}
