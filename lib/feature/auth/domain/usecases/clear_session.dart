import '../../../../core/result/result.dart';
import '../repositories/auth_repository.dart';

class ClearSession {
  const ClearSession(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call() => _repository.clearSession();
}
