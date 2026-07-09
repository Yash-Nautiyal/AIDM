import 'package:flutter/material.dart';

import '../../constant/app_dimensions.dart';
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
  });

  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(AppDimensions.appBarTotalHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return AppBar(
      backgroundColor: theme.backgroundPage,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: AppDimensions.appBarHeight,
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              icon: Icon(
                Icons.chevron_left_rounded,
                color: theme.textPrimary,
                size: 25.sp,
              ),
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            )
          : null,
      title: Text(
        title,
        style: typography.h3.copyWith(color: theme.textPrimary),
      ),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(AppDimensions.appBarBottomPadding),
        child: SizedBox(height: AppDimensions.appBarBottomPadding),
      ),
    );
  }
}
