import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:flutter/material.dart';

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({
    super.key,
    required this.onPressed,
    this.enabled = true,
  });

  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: enabled ? onPressed : null,
        icon: Icon(
          Icons.chevron_left_rounded,
          color: theme.textPrimary,
          size: 26.sp,
        ),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
