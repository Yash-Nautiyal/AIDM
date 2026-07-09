import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/input/app_input2.dart';
import 'package:flutter/material.dart';

class ScheduleAdvancedPasscodeFields extends StatelessWidget {
  const ScheduleAdvancedPasscodeFields({
    super.key,
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Padding(
      padding: EdgeInsets.only(
        left: AppDimensions.spacingLg,
        right: AppDimensions.spacingLg,
        bottom: AppDimensions.spacingVerticalLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Passcode',
            style: typography.captionLight.copyWith(color: theme.textTertiary),
          ),
          SizedBox(height: AppDimensions.spacingSm),
          AppInput2(
            controller: controller,
            hintText: 'Enter a secure passcode',
            showBorder: true,
            onChanged: onChanged,
          ),
          SizedBox(height: AppDimensions.spacingSm),
          Text(
            'Attendees will need this passcode to join your webinar',
            style: typography.captionLight.copyWith(color: theme.textTertiary),
          ),
        ],
      ),
    );
  }
}
