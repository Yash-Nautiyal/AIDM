import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/input/app_input2.dart';
import 'package:flutter/material.dart';

class ProfileLabeledField extends StatelessWidget {
  const ProfileLabeledField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.enabled = true,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: typography.bodyMedium.copyWith(
            color: theme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: AppDimensions.spacingSm),
        AppInput2(
          controller: controller,
          hintText: hintText ?? label,
          showBorder: true,
          keyboardType: keyboardType,
          enabled: enabled,
        ),
      ],
    );
  }
}
