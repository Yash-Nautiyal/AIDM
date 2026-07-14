import 'auth_resume_route.dart';

class UserSession {
  const UserSession({
    required this.email,
    this.displayName,
    this.avatarUrl,
    this.isPremium = false,
    this.isNewUser = false,
    this.isPermissionComplete = false,
    this.resumeRoute = AuthResumeRoute.welcome,
    this.permissionPageIndex = 0,
  });

  final String email;
  final String? displayName;
  final String? avatarUrl;
  final bool isPremium;
  final bool isNewUser;
  final bool isPermissionComplete;
  final AuthResumeRoute resumeRoute;
  final int permissionPageIndex;

  bool get isAuthenticated => email.isNotEmpty;

  bool get needsDisplayName =>
      displayName == null || displayName!.trim().isEmpty;

  String get greetingName {
    final name = displayName?.trim();
    if (name != null && name.isNotEmpty) {
      return name;
    }

    final at = email.indexOf('@');
    if (at > 0) {
      return email.substring(0, at);
    }

    return email;
  }

  /// Debug-only snapshot of all session fields (for logs after login).
  String toDebugString() {
    return 'email=$email'
        ', displayName=${displayName ?? 'null'}'
        ', avatarUrl=${avatarUrl ?? 'null'}'
        ', isPremium=$isPremium'
        ', isNewUser=$isNewUser'
        ', isPermissionComplete=$isPermissionComplete'
        ', resumeRoute=${resumeRoute.name}'
        ', permissionPageIndex=$permissionPageIndex';
  }

  UserSession copyWith({
    String? email,
    String? displayName,
    String? avatarUrl,
    bool? isPremium,
    bool? isNewUser,
    bool? isPermissionComplete,
    AuthResumeRoute? resumeRoute,
    int? permissionPageIndex,
  }) {
    return UserSession(
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isPremium: isPremium ?? this.isPremium,
      isNewUser: isNewUser ?? this.isNewUser,
      isPermissionComplete: isPermissionComplete ?? this.isPermissionComplete,
      resumeRoute: resumeRoute ?? this.resumeRoute,
      permissionPageIndex: permissionPageIndex ?? this.permissionPageIndex,
    );
  }
}
