import '../../../../core/result/result.dart';
import '../entities/otp_request_result.dart';
import '../entities/user_session.dart';
import '../entities/verify_otp_result.dart';

abstract interface class AuthRepository {
  /// Restores API cookies and local session metadata from disk.
  /// Returns `null` when no authenticated session exists.
  Future<Result<UserSession?>> restoreSession();

  Future<Result<OtpRequestResult>> requestOtp(String email);

  Future<Result<VerifyOtpResult>> verifyOtp({
    required String email,
    required int otp,
  });

  Future<Result<OtpRequestResult>> resendOtp(String email);

  Future<Result<void>> createAccount({
    required String email,
    required int otp,
    required String firstName,
    required String lastName,
  });

  Future<Result<void>> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
  });

  Future<Result<void>> updateAvatar(String filePath);

  /// Creates the account (new users), uploads optional avatar, and persists
  /// local session metadata. Returns the user email on success.
  Future<Result<String>> completePermission({
    required String displayName,
    String? avatarFilePath,
  });

  Future<Result<void>> signOut();

  /// Clears cookies and local session without calling a remote logout endpoint.
  Future<Result<void>> clearSession();

  Future<Result<void>> saveSessionMetadata(UserSession session);

  /// Reads local session metadata only (no cookie validation).
  Future<Result<UserSession?>> readCachedSession();
}
