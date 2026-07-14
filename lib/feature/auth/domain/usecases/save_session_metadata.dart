import '../../../../core/result/result.dart';
import '../entities/user_session.dart';
import '../repositories/auth_repository.dart';

class SaveSessionMetadata {
  const SaveSessionMetadata(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call(UserSession session) =>
      _repository.saveSessionMetadata(session);
}
