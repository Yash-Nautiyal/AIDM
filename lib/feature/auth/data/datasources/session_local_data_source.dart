import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app/app_logger.dart';
import '../../domain/entities/auth_resume_route.dart';
import '../../domain/entities/user_session.dart';
import '../models/user_session_model.dart';

class SessionLocalDataSource {
  SessionLocalDataSource(this._preferences);

  final SharedPreferences _preferences;

  static const _emailKey = 'session_email';
  static const _displayNameKey = 'session_display_name';
  static const _avatarUrlKey = 'session_avatar_url';
  static const _isPremiumKey = 'session_is_premium';
  static const _isNewUserKey = 'session_is_new_user';
  static const _isPermissionCompleteKey = 'session_is_permission_complete';
  static const _resumeRouteKey = 'session_resume_route';
  static const _permissionPageIndexKey = 'session_permission_page_index';
  static const _pendingOtpKey = 'session_pending_otp';

  // Legacy keys (pre-rename from "onboarding").
  static const _legacyPermissionCompleteKey = 'session_is_onboarding_complete';
  static const _legacyPermissionPageIndexKey = 'session_onboarding_page_index';
  static const _legacyPrecedingRouteKey = 'session_preceding_route';

  Future<UserSession?> readSession() async {
    final email = _preferences.getString(_emailKey);
    if (email == null || email.isEmpty) {
      return null;
    }

    return UserSessionModel.fromPreferences(
      email: email,
      displayName: _preferences.getString(_displayNameKey),
      avatarUrl: _preferences.getString(_avatarUrlKey),
      isPremium: _preferences.getBool(_isPremiumKey) ?? false,
      isNewUser: _preferences.getBool(_isNewUserKey) ?? false,
      isPermissionComplete: _readPermissionComplete(),
      resumeRoute: _readResumeRoute(),
      permissionPageIndex: _readPermissionPageIndex(),
    ).toEntity();
  }

  Future<void> writeSession(UserSession session) async {
    final model = UserSessionModel.fromEntity(session);

    await _preferences.setString(_emailKey, model.email);
    await _setOptionalString(_displayNameKey, model.displayName);
    await _setOptionalString(_avatarUrlKey, model.avatarUrl);
    await _preferences.setBool(_isPremiumKey, model.isPremium);
    await _preferences.setBool(_isNewUserKey, model.isNewUser);
    await _preferences.setBool(
      _isPermissionCompleteKey,
      model.isPermissionComplete,
    );
    await _preferences.setString(_resumeRouteKey, model.resumeRoute.name);
    await _preferences.setInt(
      _permissionPageIndexKey,
      model.permissionPageIndex,
    );

    AppLogger.auth(
      'prefs written: email=${model.email} route=${model.resumeRoute.name} '
      'premium=${model.isPremium} complete=${model.isPermissionComplete} '
      'permissionPage=${model.permissionPageIndex}',
    );
  }

  Future<void> clear() async {
    await _preferences.remove(_emailKey);
    await _preferences.remove(_displayNameKey);
    await _preferences.remove(_avatarUrlKey);
    await _preferences.remove(_isPremiumKey);
    await _preferences.remove(_isNewUserKey);
    await _preferences.remove(_isPermissionCompleteKey);
    await _preferences.remove(_legacyPermissionCompleteKey);
    await _preferences.remove(_resumeRouteKey);
    await _preferences.remove(_legacyPrecedingRouteKey);
    await _preferences.remove(_permissionPageIndexKey);
    await _preferences.remove(_legacyPermissionPageIndexKey);
    await _preferences.remove(_pendingOtpKey);
  }

  Future<int?> readPendingOtp() async {
    return _preferences.getInt(_pendingOtpKey);
  }

  Future<void> writePendingOtp(int otp) async {
    await _preferences.setInt(_pendingOtpKey, otp);
    AppLogger.auth('prefs written: pendingOtp saved for create-account');
  }

  Future<void> clearPendingOtp() async {
    await _preferences.remove(_pendingOtpKey);
    AppLogger.auth('prefs cleared: pendingOtp');
  }

  bool _readPermissionComplete() {
    if (_preferences.containsKey(_isPermissionCompleteKey)) {
      return _preferences.getBool(_isPermissionCompleteKey) ?? false;
    }
    return _preferences.getBool(_legacyPermissionCompleteKey) ?? false;
  }

  int _readPermissionPageIndex() {
    if (_preferences.containsKey(_permissionPageIndexKey)) {
      return _preferences.getInt(_permissionPageIndexKey) ?? 0;
    }
    return _preferences.getInt(_legacyPermissionPageIndexKey) ?? 0;
  }

  AuthResumeRoute _readResumeRoute() {
    final value = _preferences.getString(_resumeRouteKey);
    if (value == null) {
      return AuthResumeRoute.welcome;
    }

    if (value == 'onboarding') {
      return AuthResumeRoute.permission;
    }

    return AuthResumeRoute.values.firstWhere(
      (route) => route.name == value,
      orElse: () => AuthResumeRoute.welcome,
    );
  }

  Future<void> _setOptionalString(String key, String? value) async {
    if (value == null || value.isEmpty) {
      await _preferences.remove(key);
      return;
    }

    await _preferences.setString(key, value);
  }
}
