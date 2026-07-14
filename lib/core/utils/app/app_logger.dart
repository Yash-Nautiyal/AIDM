import 'package:flutter/foundation.dart';

/// Tagged debug logging. Only prints in debug mode.
abstract final class AppLogger {
  static void network(String message) => _log('Network', message);
  static void session(String message) => _log('Session', message);
  static void auth(String message) => _log('Auth', message);
  static void cookie(String message) => _log('Cookie', message);

  static void _log(String tag, String message) {
    if (!kDebugMode) return;
    debugPrint('[$tag] $message');
  }
}
