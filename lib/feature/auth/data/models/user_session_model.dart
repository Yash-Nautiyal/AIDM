import '../../domain/entities/auth_resume_route.dart';
import '../../domain/entities/user_session.dart';

class UserSessionModel {
  const UserSessionModel({
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

  factory UserSessionModel.fromEntity(UserSession session) {
    return UserSessionModel(
      email: session.email,
      displayName: session.displayName,
      avatarUrl: session.avatarUrl,
      isPremium: session.isPremium,
      isNewUser: session.isNewUser,
      isPermissionComplete: session.isPermissionComplete,
      resumeRoute: session.resumeRoute,
      permissionPageIndex: session.permissionPageIndex,
    );
  }

  factory UserSessionModel.fromPreferences({
    required String email,
    String? displayName,
    String? avatarUrl,
    bool isPremium = false,
    bool isNewUser = false,
    bool isPermissionComplete = false,
    AuthResumeRoute resumeRoute = AuthResumeRoute.welcome,
    int permissionPageIndex = 0,
  }) {
    return UserSessionModel(
      email: email,
      displayName: displayName,
      avatarUrl: avatarUrl,
      isPremium: isPremium,
      isNewUser: isNewUser,
      isPermissionComplete: isPermissionComplete,
      resumeRoute: resumeRoute,
      permissionPageIndex: permissionPageIndex,
    );
  }

  UserSession toEntity() {
    return UserSession(
      email: email,
      displayName: displayName,
      avatarUrl: avatarUrl,
      isPremium: isPremium,
      isNewUser: isNewUser,
      isPermissionComplete: isPermissionComplete,
      resumeRoute: resumeRoute,
      permissionPageIndex: permissionPageIndex,
    );
  }
}
