import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constant/app_animations.dart';
import '../../constant/app_dimensions.dart';
import '../../routes/app_router.dart';
import '../../theme/app_theme_extension.dart';
import '../../theme/typography/app_typography_extension.dart';
import '../../utils/responsive_extension.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.onBack,
    this.actions,
    this.showBottomBorder = true,
    this.glassy = true,
    this.blurSigma = AppAnimations.appBarBlurSigma,
    this.glassOpacity = AppAnimations.appBarGlassOpacity,
  });

  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final bool showBottomBorder;
  final bool glassy;
  final double blurSigma;
  final double glassOpacity;

  @override
  Size get preferredSize => Size.fromHeight(
    AppDimensions.appBarTotalHeight + (showBottomBorder ? 1 : 0),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    final bar = Material(
      color: glassy ? Colors.transparent : theme.backgroundPage,
      elevation: 0,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: AppDimensions.appBarHeight,
              child: NavigationToolbar(
                leading: showBack
                    ? IconButton(
                        icon: Icon(
                          Icons.chevron_left_rounded,
                          color: theme.textPrimary,
                          size: 25.sp,
                        ),
                        onPressed: onBack ?? () => maybeMoveBack(context),
                      )
                    : const SizedBox(width: kMinInteractiveDimension),
                middle: Text(
                  title,
                  style: typography.h3.copyWith(color: theme.textPrimary),
                ),
                centerMiddle: true,
                trailing: actions == null
                    ? const SizedBox(width: kMinInteractiveDimension)
                    : Padding(
                        padding: EdgeInsets.only(
                          right: AppDimensions.spacingLg,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: actions!,
                        ),
                      ),
              ),
            ),
            SizedBox(height: AppDimensions.appBarBottomPadding),
            if (showBottomBorder)
              Divider(height: 1, thickness: 1, color: theme.borderDefault),
          ],
        ),
      ),
    );

    if (!glassy) return bar;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.backgroundPage.withValues(alpha: glassOpacity),
          ),
          child: bar,
        ),
      ),
    );
  }
}
