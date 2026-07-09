import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/input/app_input2.dart';
import 'package:flutter/material.dart';

class ScheduleTitleSection extends StatelessWidget {
  const ScheduleTitleSection({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Title',
          style: typography.bodyMedium.copyWith(color: theme.textSecondary),
        ),
        SizedBox(height: AppDimensions.spacingSm),
        AppInput2(
          controller: controller,
          hintText: 'Enter your webinar title',
          showBorder: true,
        ),
        SizedBox(height: AppDimensions.spacingSm),
        Text(
          'Choose a clear, descriptive title for your webinar',
          style: typography.captionLight.copyWith(color: theme.textTertiary),
        ),
      ],
    );
  }
}

