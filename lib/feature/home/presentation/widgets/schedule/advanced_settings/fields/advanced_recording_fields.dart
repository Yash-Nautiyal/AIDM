import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/widgets/bottom_sheet/app_bottom_options.dart';
import 'package:flutter/material.dart';

import '../repeat/repeat_select_field.dart';

class ScheduleAdvancedRecordingFields extends StatelessWidget {
  const ScheduleAdvancedRecordingFields({
    super.key,
    required this.visibility,
    required this.onVisibilityChanged,
  });

  final String visibility;
  final ValueChanged<String> onVisibilityChanged;

  static const visibilityOptions = [
    'Public - Anyone with the link',
    'Invited users only',
    'Private - Host only',
  ];

  Future<void> _openVisibilitySheet(BuildContext context) async {
    final result = await showAppBottomSheetOptions(
      context,
      options: visibilityOptions,
      selected: visibility,
    );
    if (result == null) return;
    onVisibilityChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimensions.spacingLg,
        right: AppDimensions.spacingLg,
        bottom: AppDimensions.spacingVerticalLg,
      ),
      child: LabeledSelectField(
        label: 'Recording visibility',
        value: visibility,
        isExpanded: false,
        onTap: () => _openVisibilitySheet(context),
      ),
    );
  }
}
