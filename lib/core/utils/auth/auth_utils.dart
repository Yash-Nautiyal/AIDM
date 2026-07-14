import '../../../../core/result/app_failure.dart';

String messageForAuthFailure(AppFailure failure) {
  return switch (failure) {
    NetworkFailure() => 'Network error. Check your connection and try again.',
    UnauthorizedFailure() => 'Session expired. Please try again.',
    ValidationFailure(:final message) => message,
    ServerFailure(:final message) =>
      message ?? 'Something went wrong. Please try again.',
    UnknownFailure(:final message) =>
      message ?? 'Something went wrong. Please try again.',
  };
}

bool readBool(Map<String, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value is bool) {
      return value;
    }
  }
  return false;
}

String? readString(Map<String, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value is String && value.isNotEmpty) {
      return value;
    }
  }
  return null;
}

/// Resolves the nested `user` object from verify-otp / profile API payloads.
Map<String, dynamic> readUserMap(Map<String, dynamic> json) {
  final user = json['user'];
  if (user is Map<String, dynamic>) {
    return user;
  }

  final data = json['data'];
  if (data is Map<String, dynamic>) {
    final nestedUser = data['user'];
    if (nestedUser is Map<String, dynamic>) {
      return nestedUser;
    }
  }

  return const {};
}

String? readDisplayName(Map<String, dynamic> json) {
  final user = readUserMap(json);

  final direct = readString(user, const [
    'displayName',
    'display_name',
    'name',
  ]);
  if (direct != null) {
    return direct;
  }

  final firstName = readString(user, const [
    'firstName',
    'first_name',
    'firstname',
  ]);
  final lastName = readString(user, const [
    'lastName',
    'last_name',
    'lastname',
  ]);
  if (firstName != null || lastName != null) {
    return [
      firstName,
      lastName,
    ].whereType<String>().where((part) => part.isNotEmpty).join(' ').trim();
  }

  return readString(json, const ['displayName', 'display_name', 'name']);
}
