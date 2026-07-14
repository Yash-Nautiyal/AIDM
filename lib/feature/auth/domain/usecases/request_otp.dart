import '../../../../core/result/result.dart';
import '../entities/otp_request_result.dart';
import '../repositories/auth_repository.dart';

class RequestOtp {
  const RequestOtp(this._repository);

  final AuthRepository _repository;

  Future<Result<OtpRequestResult>> call(String email) =>
      _repository.requestOtp(email);
}
