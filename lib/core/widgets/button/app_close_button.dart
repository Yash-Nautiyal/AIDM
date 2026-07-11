import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppCloseButton extends StatelessWidget {
  final VoidCallback onTap;
  const AppCloseButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    return Material(
      color: theme.backgroundInput,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spacingSm),
          child: SvgPicture.asset(
            AppAssets.closeIcon,
            width: AppDimensions.iconSizeSm,
            colorFilter: ColorFilter.mode(theme.textSecondary, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
