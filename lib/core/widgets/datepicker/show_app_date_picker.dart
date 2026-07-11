import 'package:aidm/core/routes/app_router.dart';
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
          onClear: () => moveBack<DateTime?>(context, null),
          onDone: () => moveBack<DateTime>(context, result!),
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
          onClear: () => moveBack<TimeOfDay?>(context, null),
          onDone: () => moveBack<TimeOfDay>(context, result!),
        ),
      );
    },
  );
}
