import 'package:flutter/foundation.dart';

/// In-memory auth session. Swap the backing store later (prefs / secure storage)
/// without changing [AuthGate] or call sites.
class AppSession extends ChangeNotifier {
  AppSession._();

  static final AppSession instance = AppSession._();

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  /// TODO(backend): Hydrate from secure storage / refresh-token API on app start
  /// before [AuthGate] first builds (e.g. `await AppSession.instance.restore()`).
  Future<void> restore() async {
    // no-op until backend / local token persistence is wired
  }

  void signIn() {
    // TODO(backend): Persist access/refresh tokens (and user id) after auth API succeeds
    if (_isAuthenticated) return;
    _isAuthenticated = true;
    notifyListeners();
  }

  void signOut() {
    // TODO(backend): Call logout API if required, then clear tokens from secure storage
    if (!_isAuthenticated) return;
    _isAuthenticated = false;
    notifyListeners();
  }
}
