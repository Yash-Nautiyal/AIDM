import 'dart:io';

import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/result/result.dart';
import 'package:aidm/core/routes/auth_routes.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:aidm/core/utils/common/text_utils.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/carousel/app_carousel_dots.dart';
import 'package:aidm/core/widgets/dialog/ios_action_sheet.dart';
import 'package:aidm/feature/auth/domain/entities/auth_resume_route.dart';
import 'package:aidm/feature/auth/domain/repositories/auth_repository.dart';
import 'package:aidm/feature/auth/domain/usecases/complete_permission.dart';
import 'package:aidm/feature/auth/domain/usecases/save_session_metadata.dart';
import 'package:aidm/feature/auth/domain/usecases/update_avatar.dart';
import 'package:aidm/feature/auth/domain/usecases/update_profile.dart';
import 'package:aidm/feature/auth/presentation/bloc/session/session_bloc.dart';
import 'package:aidm/feature/auth/presentation/bloc/session/session_event.dart';
import 'package:aidm/core/utils/auth/auth_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/profile_slide.dart';
import '../widgets/sliding_page_layout.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key, this.profileOnly = false});

  /// When true, opens directly to the profile slide (existing users missing
  /// display name after login/restore).
  final bool profileOnly;

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage>
    with WidgetsBindingObserver {
  static const _slideCount = 3;
  static const _profileSlideIndex = 2;

  final _pageController = PageController();
  final _displayNameController = TextEditingController();
  final _imagePicker = ImagePicker();

  int _currentIndex = 0;
  File? _profileImage;
  bool _notificationRequested = false;
  bool _calendarRequested = false;
  bool _isSubmitting = false;
  String? _errorMessage;

  late final CompletePermission _completePermission;
  late final SaveSessionMetadata _saveSessionMetadata;
  late final UpdateProfile _updateProfile;
  late final UpdateAvatar _updateAvatar;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final repository = context.read<AuthRepository>();
    _completePermission = CompletePermission(repository);
    _saveSessionMetadata = SaveSessionMetadata(repository);
    _updateProfile = UpdateProfile(repository);
    _updateAvatar = UpdateAvatar(repository);
    _restorePageState();
  }

  Future<void> _restorePageState() async {
    final result = await context.read<AuthRepository>().readCachedSession();
    final session = result.fold(
      onSuccess: (value) => value,
      onFailure: (_) => null,
    );

    final displayName = session?.displayName;
    if (displayName != null && displayName.isNotEmpty) {
      _displayNameController.text = displayName;
    }

    if (widget.profileOnly) {
      if (!mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _pageController.jumpToPage(_profileSlideIndex);
        setState(() => _currentIndex = _profileSlideIndex);
      });
      return;
    }

    final index = await _resolveInitialSlide(session?.permissionPageIndex ?? 0);
    if (!mounted || index <= 0) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _pageController.jumpToPage(index);
      setState(() => _currentIndex = index);
    });
  }

  /// OS is source of truth for notification/calendar; prefs only restore profile slide.
  Future<int> _resolveInitialSlide(int savedIndex) async {
    final notification = await Permission.notification.status;
    final calendar = await _calendarPermission.status;

    var fromOs = 0;
    if (notification.isGranted) fromOs = 1;
    if (calendar.isGranted) fromOs = 2;

    if (savedIndex >= _profileSlideIndex) return _profileSlideIndex;
    return fromOs > savedIndex ? fromOs : savedIndex;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _syncSlidesWithOsPermissions();
    }
  }

  Future<void> _syncSlidesWithOsPermissions() async {
    if (!mounted || widget.profileOnly) return;

    final index = await _resolveInitialSlide(_currentIndex);
    if (index == _currentIndex) return;

    _pageController.jumpToPage(index);
    setState(() => _currentIndex = index);
  }

  Permission get _calendarPermission => Platform.isIOS
      ? Permission.calendarFullAccess
      : Permission.calendarWriteOnly;

  void _goToSlide(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentIndex = index);

    if (index == _profileSlideIndex) {
      _persistProfileSlide();
    }
  }

  Future<void> _persistProfileSlide() async {
    final result = await context.read<AuthRepository>().readCachedSession();
    final session = result.fold(
      onSuccess: (value) => value,
      onFailure: (_) => null,
    );
    if (session == null || !mounted) return;

    final trimmedName = _displayNameController.text.trim();

    await _saveSessionMetadata(
      session.copyWith(
        permissionPageIndex: _profileSlideIndex,
        resumeRoute: AuthResumeRoute.permission,
        displayName: trimmedName.isNotEmpty ? trimmedName : session.displayName,
      ),
    );
  }

  Future<void> _finishPermission() async {
    if (_isSubmitting) return;

    if (widget.profileOnly) {
      await _finishExistingUserProfile();
      return;
    }

    final cachedResult = await context.read<AuthRepository>().readCachedSession();
    final session = cachedResult.fold(
      onSuccess: (value) => value,
      onFailure: (_) => null,
    );

    if (session != null && !session.isNewUser) {
      await _finishExistingUserProfile();
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final result = await _completePermission(
      CompletePermissionParams(
        displayName: _displayNameController.text,
        avatarFilePath: _profileImage?.path,
      ),
    );

    if (!mounted) return;

    result.fold(
      onSuccess: (email) => AuthRoutes.toPremium(context, email: email),
      onFailure: (failure) {
        setState(() {
          _isSubmitting = false;
          _errorMessage = messageForAuthFailure(failure);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      },
    );
  }

  Future<void> _finishExistingUserProfile() async {
    final trimmedName = _displayNameController.text.trim();
    if (trimmedName.isEmpty) {
      setState(() => _errorMessage = 'Please enter a display name.');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final cachedResult = await context.read<AuthRepository>().readCachedSession();
    final baseSession = cachedResult.fold(
      onSuccess: (value) => value,
      onFailure: (_) => null,
    );

    if (baseSession == null || !mounted) {
      setState(() {
        _isSubmitting = false;
        _errorMessage = 'Session not found. Please sign in again.';
      });
      return;
    }

    final (firstName, lastName) = parseDisplayName(trimmedName);

    final result = await _updateProfile(
      UpdateProfileParams(
        firstName: firstName,
        lastName: lastName,
        email: baseSession.email,
      ),
    );

    if (!mounted) return;

    await result.fold(
      onSuccess: (_) async {
        if (_profileImage != null) {
          await _updateAvatar(_profileImage!.path);
        }

        if (!mounted) return;

        final updated = baseSession.copyWith(
          displayName: trimmedName,
          permissionPageIndex: 0,
          resumeRoute: baseSession.isPremium
              ? AuthResumeRoute.welcome
              : AuthResumeRoute.subscription,
        );

        if (widget.profileOnly || baseSession.isPermissionComplete) {
          context.read<SessionBloc>().add(SessionProfileUpdated(updated));
          return;
        }

        await _saveSessionMetadata(updated);
        if (!mounted) return;

        if (baseSession.isPremium) {
          context.read<SessionBloc>().add(
            SessionSignedIn(
              updated.copyWith(isPermissionComplete: true),
            ),
          );
        } else {
          await AuthRoutes.toPremium(context, email: baseSession.email);
        }
      },
      onFailure: (failure) {
        setState(() {
          _isSubmitting = false;
          _errorMessage = messageForAuthFailure(failure);
        });
      },
    );
  }

  Future<void> _requestNotificationPermission() async {
    await _requestAndAdvance(
      permission: Permission.notification,
      hasRequested: _notificationRequested,
      onRequested: () => _notificationRequested = true,
      onGranted: () => _goToSlide(1),
    );
  }

  Future<void> _requestCalendarPermission() async {
    await _requestAndAdvance(
      permission: _calendarPermission,
      hasRequested: _calendarRequested,
      onRequested: () => _calendarRequested = true,
      onGranted: () => _goToSlide(_profileSlideIndex),
    );
  }

  Future<void> _requestAndAdvance({
    required Permission permission,
    required bool hasRequested,
    required VoidCallback onRequested,
    required VoidCallback onGranted,
  }) async {
    var status = await permission.status;
    if (status.isGranted) {
      onGranted();
      return;
    }

    if (hasRequested) {
      await openAppSettings();
      return;
    }

    onRequested();
    status = await permission.request();
    if (!mounted) return;
    if (status.isGranted) {
      onGranted();
    }
  }

  Future<void> _showProfilePictureActionSheet() async {
    await showIosActionSheet(
      context,
      options: [
        IosActionSheetOption(
          label: 'Camera',
          onPressed: () => _pickImage(ImageSource.camera),
        ),
        IosActionSheetOption(
          label: 'Select from photo album',
          onPressed: () => _pickImage(ImageSource.gallery),
        ),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final permission = source == ImageSource.camera
        ? Permission.camera
        : Permission.photos;

    final status = await permission.request();
    if (!status.isGranted && !status.isLimited) return;

    final pickedFile = await _imagePicker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (pickedFile == null || !mounted) return;

    setState(() => _profileImage = File(pickedFile.path));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                  if (index == _profileSlideIndex) {
                    _persistProfileSlide();
                  }
                },
                children: [
                  _NotificationsSlide(
                    onEnableNotifications: _requestNotificationPermission,
                  ),
                  _CalendarSlide(onContinue: _requestCalendarPermission),
                  ProfileSlide(
                    displayNameController: _displayNameController,
                    profileImage: _profileImage,
                    errorMessage: _errorMessage,
                    isSubmitting: _isSubmitting,
                    onUploadPhoto: _showProfilePictureActionSheet,
                    onContinue: _isSubmitting ? null : _finishPermission,
                    onNotNow: _isSubmitting ? null : _finishPermission,
                  ),
                ],
              ),
            ),
            if (!widget.profileOnly)
              Padding(
                padding: EdgeInsets.only(bottom: AppDimensions.spacingLg),
                child: AppCarouselDots(
                  count: _slideCount,
                  currentIndex: _currentIndex,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NotificationsSlide extends StatelessWidget {
  const _NotificationsSlide({required this.onEnableNotifications});

  final VoidCallback onEnableNotifications;

  @override
  Widget build(BuildContext context) {
    return SlidingPageLayout(
      title: 'Get notified',
      subtitle:
          'Get a heads-up before you go live, when attendees join, and when your recording is ready to share.',
      illustration: Image.asset(
        AppAssets.phoneNotificationsImg,
        width: 305.w,
        height: 319.h,
        fit: BoxFit.contain,
      ),
      actions: [
        AppButton(
          label: 'Enable notifications',
          onPressed: onEnableNotifications,
        ),
      ],
    );
  }
}

class _CalendarSlide extends StatelessWidget {
  const _CalendarSlide({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return SlidingPageLayout(
      title: 'Never miss a meeting',
      subtitle:
          "We'll add your upcoming sessions to your calendar so you never go live late or miss a scheduled broadcast.",
      illustration: Image.asset(
        AppAssets.calendarNotificationsImg,
        width: 305.w,
        height: 319.h,
        fit: BoxFit.contain,
      ),
      actions: [AppButton(label: 'Continue', onPressed: onContinue)],
    );
  }
}
