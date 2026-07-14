import '../../../../core/result/result.dart';
import '../entities/user_session.dart';
import '../repositories/auth_repository.dart';

class ReadCachedSession {
  const ReadCachedSession(this._repository);

  final AuthRepository _repository;

  Future<Result<UserSession?>> call() => _repository.readCachedSession();
}
