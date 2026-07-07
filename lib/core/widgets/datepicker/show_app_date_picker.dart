import 'package:flutter/material.dart';

import '../../constant/app_dimensions.dart';
import 'app_date_picker.dart';
import 'app_time_picker.dart';

Future<DateTime?> showAppDatePicker(
  BuildContext context, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  DateTime? result = initialDate ?? DateTime.now();

  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(AppDimensions.spacingLg),
        child: AppDatePicker(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          onDateChanged: (date) => result = date,
          onClear: () => Navigator.of(context).pop<DateTime?>(null),
          onDone: () => Navigator.of(context).pop<DateTime>(result!),
        ),
      );
    },
  );
}

Future<TimeOfDay?> showAppTimePicker(
  BuildContext context, {
  TimeOfDay? initialTime,
}) {
  TimeOfDay? result = initialTime ?? TimeOfDay.now();

  return showModalBottomSheet<TimeOfDay>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(AppDimensions.spacingLg),
        child: AppTimePicker(
          initialTime: initialTime,
          onTimeChanged: (time) => result = time,
          onClear: () => Navigator.of(context).pop<TimeOfDay?>(null),
          onDone: () => Navigator.of(context).pop<TimeOfDay>(result!),
        ),
      );
    },
  );
}
