import 'dart:io';

import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/input/app_input1.dart';
import 'package:flutter/material.dart';

import 'sliding_page_layout.dart';

class ProfileSlide extends StatelessWidget {
  const ProfileSlide({
    super.key,
    required this.displayNameController,
    required this.profileImage,
    required this.errorMessage,
    required this.isSubmitting,
    required this.onUploadPhoto,
    required this.onContinue,
    required this.onNotNow,
  });

  final TextEditingController displayNameController;
  final File? profileImage;
  final String? errorMessage;
  final bool isSubmitting;
  final VoidCallback onUploadPhoto;
  final VoidCallback? onContinue;
  final VoidCallback? onNotNow;

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
            enabled: !isSubmitting,
          ),
          if (errorMessage != null) ...[
            SizedBox(height: AppDimensions.spacingSm),
            Text(
              errorMessage!,
              style: typography.captionLight.copyWith(color: theme.textDanger),
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(height: AppDimensions.spacingSm),
          Text(
            'Enter a name (e.g. first name, last name, or nickname)',
            style: typography.captionLight.copyWith(color: theme.textTertiary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        AppButton(
          label: 'Continue',
          isLoading: isSubmitting,
          onPressed: onContinue,
        ),
        AppButton(label: 'Not Now', onPressed: onNotNow, enabled: false),
      ],
    );
  }
}
