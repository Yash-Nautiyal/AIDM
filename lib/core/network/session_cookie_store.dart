import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app/app_logger.dart';

/// Persists `connect.sid` in SharedPreferences for reliable iOS session restore.
class SessionCookieStore {
  SessionCookieStore(this._preferences);

  static const _key = 'session_connect_sid';

  final SharedPreferences _preferences;
  String? _cached;

  Future<void> init() async {
    _cached = _preferences.getString(_key);
    AppLogger.cookie(
      _cached != null
          ? 'Restored session cookie from prefs (length=${_cached!.length})'
          : 'No session cookie in prefs',
    );
  }

  String? get sessionId => _cached;
  bool get hasSession => _cached != null && _cached!.isNotEmpty;

  Future<void> save(String sessionId) async {
    if (sessionId.isEmpty) return;
    _cached = sessionId;
    await _preferences.setString(_key, sessionId);
    AppLogger.cookie('Saved session cookie to prefs (length=${sessionId.length})');
  }

  Future<void> clear() async {
    _cached = null;
    await _preferences.remove(_key);
    AppLogger.cookie('Cleared session cookie from prefs');
  }
}
