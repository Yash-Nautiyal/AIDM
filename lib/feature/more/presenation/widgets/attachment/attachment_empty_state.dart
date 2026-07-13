import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:flutter/material.dart';

class AttachmentEmptyState extends StatelessWidget {
  const AttachmentEmptyState({super.key, required this.onUpload});

  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing2xl),
      child: Column(
        children: [
          const Spacer(flex: 2),
          Text(
            'No attachments',
            style: typography.h3.copyWith(color: theme.textPrimary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimensions.spacingVerticalSm),
          Text(
            'The Scheduled webinars will be listed here',
            style: typography.bodyMedium.copyWith(color: theme.textSecondary),
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 2),
          AppButton(label: 'Upload', onPressed: onUpload),
          SizedBox(height: AppDimensions.spacingVertical3xl),
        ],
      ),
    );
  }
}
