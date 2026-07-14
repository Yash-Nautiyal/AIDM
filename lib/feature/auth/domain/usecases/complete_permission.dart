import '../../../../core/result/result.dart';
import '../repositories/auth_repository.dart';

class CompletePermissionParams {
  const CompletePermissionParams({
    required this.displayName,
    this.avatarFilePath,
  });

  final String displayName;
  final String? avatarFilePath;
}

class CompletePermission {
  const CompletePermission(this._repository);

  final AuthRepository _repository;

  Future<Result<String>> call(CompletePermissionParams params) {
    return _repository.completePermission(
      displayName: params.displayName,
      avatarFilePath: params.avatarFilePath,
    );
  }
}
