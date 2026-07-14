import '../../../../core/result/result.dart';
import '../repositories/auth_repository.dart';

class UpdateAvatar {
  const UpdateAvatar(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call(String filePath) =>
      _repository.updateAvatar(filePath);
}
