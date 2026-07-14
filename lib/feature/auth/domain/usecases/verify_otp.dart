import '../../../../core/result/result.dart';
import '../entities/verify_otp_result.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpParams {
  const VerifyOtpParams({
    required this.email,
    required this.otp,
  });

  final String email;
  final int otp;
}

class VerifyOtp {
  const VerifyOtp(this._repository);

  final AuthRepository _repository;

  Future<Result<VerifyOtpResult>> call(VerifyOtpParams params) {
    return _repository.verifyOtp(email: params.email, otp: params.otp);
  }
}
