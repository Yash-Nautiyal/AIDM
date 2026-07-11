import 'dart:io';

import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/carousel/app_carousel_dots.dart';
import 'package:aidm/core/widgets/dialog/ios_action_sheet.dart';
import 'package:aidm/core/widgets/input/app_input1.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/sliding_page_layout.dart';
import 'premium_page.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage>
    with WidgetsBindingObserver {
  static const _slideCount = 3;

  final _pageController = PageController();
  final _displayNameController = TextEditingController();
  final _imagePicker = ImagePicker();

  int _currentIndex = 0;
  File? _profileImage;
  bool _notificationRequested = false;
  bool _calendarRequested = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
      _checkPermissionOnResume();
    }
  }

  Future<void> _checkPermissionOnResume() async {
    if (!mounted) return;

    if (_currentIndex == 0) {
      final status = await Permission.notification.status;
      if (status.isGranted) _goToSlide(1);
    } else if (_currentIndex == 1) {
      final permission = _calendarPermission;
      final status = await permission.status;
      if (status.isGranted) _goToSlide(2);
    }
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
  }

  void _finishOnboarding() {
    moveTo(context, const PremiumPage(), clearStack: true);
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
      onGranted: () => _goToSlide(2),
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
      // iOS never re-shows the system dialog after the first denial.
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
                onPageChanged: (index) => setState(() => _currentIndex = index),
                children: [
                  _NotificationsSlide(
                    onEnableNotifications: _requestNotificationPermission,
                  ),
                  _CalendarSlide(onContinue: _requestCalendarPermission),
                  _ProfileSlide(
                    displayNameController: _displayNameController,
                    profileImage: _profileImage,
                    onUploadPhoto: _showProfilePictureActionSheet,
                    onContinue: _finishOnboarding,
                    onNotNow: _finishOnboarding,
                  ),
                ],
              ),
            ),
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

class _ProfileSlide extends StatelessWidget {
  const _ProfileSlide({
    required this.displayNameController,
    required this.profileImage,
    required this.onUploadPhoto,
    required this.onContinue,
    required this.onNotNow,
  });

  final TextEditingController displayNameController;
  final File? profileImage;
  final VoidCallback onUploadPhoto;
  final VoidCallback onContinue;
  final VoidCallback onNotNow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return SlidingPageLayout(
      title: 'Personalize your profile',
      subtitle:
          'A complete profile gets 3x more returning attendees. Takes 10 seconds your audience will notice.',
      illustration: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onUploadPhoto,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: theme.brandPrimary,
                shape: BoxShape.circle,
                image: profileImage != null
                    ? DecorationImage(
                        image: FileImage(profileImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
          ),
          SizedBox(height: AppDimensions.spacingMd),
          GestureDetector(
            onTap: onUploadPhoto,
            child: Text(
              'Upload profile picture',
              style: typography.bodyMedium.copyWith(color: theme.brandPrimary),
            ),
          ),
        ],
      ),
      footer: Column(
        children: [
          AppInput(
            controller: displayNameController,
            hintText: 'Display Name',
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: AppDimensions.spacingSm),
          Text(
            'Enter a name (e.g. first name, last name, or nickname)',
            style: typography.captionLight.copyWith(color: theme.textTertiary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        AppButton(label: 'Continue', onPressed: onContinue),
        AppButton(label: 'Not Now', onPressed: onNotNow, enabled: false),
      ],
    );
  }
}
