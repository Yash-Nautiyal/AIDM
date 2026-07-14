import 'app_failure.dart';

sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final AppFailure failure;
}

extension ResultX<T> on Result<T> {
  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is FailureResult<T>;

  T? get valueOrNull => switch (this) {
    Success(:final value) => value,
    FailureResult() => null,
  };

  AppFailure? get failureOrNull => switch (this) {
    Success() => null,
    FailureResult(:final failure) => failure,
  };

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(AppFailure failure) onFailure,
  }) {
    return switch (this) {
      Success(:final value) => onSuccess(value),
      FailureResult(:final failure) => onFailure(failure),
    };
  }
}
