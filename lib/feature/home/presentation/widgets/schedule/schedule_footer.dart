import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:flutter/material.dart';

class ScheduleFooter extends StatelessWidget {
  const ScheduleFooter({super.key, this.onSave, this.onCancel});

  final VoidCallback? onSave;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(label: 'Save', onPressed: onSave),
        SizedBox(height: AppDimensions.spacingMd),
        AppButton(
          label: 'Cancel',
          type: AppButton1Type.secondary,
          onPressed: onCancel,
        ),
      ],
    );
  }
}
