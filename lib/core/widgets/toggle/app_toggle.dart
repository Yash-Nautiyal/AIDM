import 'package:flutter/material.dart';

import '../../theme/app_theme_extension.dart';

class AppToggle extends StatelessWidget {
  const AppToggle({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    return Switch(
      value: value,
      onChanged: onChanged,
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return theme.switchTrackActive;
        }
        return theme.switchTrack;
      }),
      thumbColor: WidgetStatePropertyAll(theme.brandPrimaryTint),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      trackOutlineWidth: const WidgetStatePropertyAll(0),
    );
  }
}
