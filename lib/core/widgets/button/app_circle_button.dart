import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppCircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? iconPath;
  const AppCircleButton({super.key, required this.onTap, this.iconPath});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    return Material(
      color: theme.brandPrimary,
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: theme.brandPrimary.withValues(alpha: 0.35),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spacingMd),
          child: SvgPicture.asset(
            iconPath ?? AppAssets.addIcon,
            width: AppDimensions.iconSizeMd,
            height: AppDimensions.iconSizeMd,
            colorFilter: ColorFilter.mode(
              theme.brandPrimaryTint,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
