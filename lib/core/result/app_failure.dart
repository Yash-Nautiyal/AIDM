sealed class AppFailure {
  const AppFailure();
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure();
}

final class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure();
}

final class ServerFailure extends AppFailure {
  const ServerFailure({this.message});

  final String? message;
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure({required this.message});

  final String message;
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure({this.message});

  final String? message;
}
