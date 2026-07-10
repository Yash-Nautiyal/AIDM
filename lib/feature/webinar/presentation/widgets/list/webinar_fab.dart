import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WebinarFab extends StatelessWidget {
  const WebinarFab({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Material(
      color: theme.brandPrimary,
      shape: const CircleBorder(),
      elevation: 4,
      shadowColor: theme.brandPrimary.withValues(alpha: 0.35),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56.w,
          height: 56.w,
          child: Center(
            child: SvgPicture.asset(
              AppAssets.addIcon,
              width: AppDimensions.iconSizeLg,
              height: AppDimensions.iconSizeLg,
              colorFilter: ColorFilter.mode(
                theme.brandPrimaryTint,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
