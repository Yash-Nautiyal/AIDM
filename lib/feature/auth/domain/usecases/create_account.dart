import '../../../../core/result/result.dart';
import '../repositories/auth_repository.dart';

class CreateAccountParams {
  const CreateAccountParams({
    required this.email,
    required this.otp,
    required this.firstName,
    required this.lastName,
  });

  final String email;
  final int otp;
  final String firstName;
  final String lastName;
}

class CreateAccount {
  const CreateAccount(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call(CreateAccountParams params) {
    return _repository.createAccount(
      email: params.email,
      otp: params.otp,
      firstName: params.firstName,
      lastName: params.lastName,
    );
  }
}
