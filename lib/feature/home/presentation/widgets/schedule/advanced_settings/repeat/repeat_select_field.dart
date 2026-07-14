import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:flutter/material.dart';

import 'repeat_trailing.dart';

class LabeledSelectField extends StatelessWidget {
  const LabeledSelectField({
    super.key,
    required this.label,
    required this.value,
    required this.isExpanded,
    required this.onTap,
  });

  final String label;
  final String value;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: typography.captionLight.copyWith(color: theme.textTertiary),
        ),
        SizedBox(height: AppDimensions.spacingSm),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
            child: Ink(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingMd,
                vertical: 11.h,
              ),
              decoration: BoxDecoration(
                color: theme.backgroundPage,
                borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                border: Border.all(color: theme.borderDefault),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(value, style: typography.body)),
                  UnfoldMoreTrailingIcon(isExpanded: isExpanded),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
