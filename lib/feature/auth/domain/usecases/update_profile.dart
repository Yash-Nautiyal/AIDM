import '../../../../core/result/result.dart';
import '../repositories/auth_repository.dart';

class UpdateProfileParams {
  const UpdateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final String firstName;
  final String lastName;
  final String email;
}

class UpdateProfile {
  const UpdateProfile(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call(UpdateProfileParams params) {
    return _repository.updateProfile(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
    );
  }
}
