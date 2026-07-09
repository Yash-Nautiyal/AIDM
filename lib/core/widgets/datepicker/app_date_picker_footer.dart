import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:flutter/material.dart';

import '../../constant/app_dimensions.dart';
import '../../theme/typography/app_typography_extension.dart';

class AppDatePickerFooter extends StatelessWidget {
  const AppDatePickerFooter({
    super.key,
    this.onClear,
    this.onDone,
    this.clearLabel = 'Clear',
    this.doneLabel = 'Done',
  });

  final VoidCallback? onClear;
  final VoidCallback? onDone;
  final String clearLabel;
  final String doneLabel;

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingLg,
      ).copyWith(bottom: AppDimensions.spacingVerticalXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: onClear,
              child: Center(child: Text(clearLabel, style: typography.label)),
            ),
          ),
          Expanded(
            child: AppButton(
              onPressed: onDone,
              label: doneLabel,
              expand: false,
            ),
          ),
        ],
      ),
    );
  }
}
