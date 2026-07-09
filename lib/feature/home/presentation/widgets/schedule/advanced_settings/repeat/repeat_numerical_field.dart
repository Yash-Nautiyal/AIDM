import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:flutter/material.dart';

import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/input/app_input2.dart';

import 'repeat_trailing.dart';

class LabeledNumericField extends StatelessWidget {
  const LabeledNumericField({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
    this.suffix,
  });

  final String label;
  final TextEditingController controller;
  final ValueChanged<int> onChanged;
  final String? suffix;

  int get _currentValue {
    final parsed = int.tryParse(controller.text.trim());
    return parsed == null || parsed <= 0 ? 1 : parsed;
  }

  void _updateValue(int value) {
    final next = value <= 0 ? 1 : value;
    controller.text = '$next';
    onChanged(next);
  }

  void _handleChanged(String value) {
    final parsed = int.tryParse(value.trim());
    if (parsed == null) return;
    onChanged(parsed <= 0 ? 1 : parsed);
  }

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
        AppInput2(
          controller: controller,
          hintText: '1',
          showBorder: true,
          keyboardType: TextInputType.number,
          onChanged: _handleChanged,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (suffix != null) ...[
                Text(
                  suffix!,
                  style: typography.captionLight.copyWith(
                    color: theme.textTertiary,
                  ),
                ),
                SizedBox(width: AppDimensions.spacingSm),
              ],
              UnfoldMoreStepper(
                onIncrement: () => _updateValue(_currentValue + 1),
                onDecrement: () => _updateValue(_currentValue - 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
