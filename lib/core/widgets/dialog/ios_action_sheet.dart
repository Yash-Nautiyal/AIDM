import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_colors.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme_extension.dart';

class IosActionSheetOption {
  const IosActionSheetOption({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;
}

Future<void> showIosActionSheet(
  BuildContext context, {
  required List<IosActionSheetOption> options,
  String cancelLabel = 'Cancel',
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black.withValues(alpha: 0.45),
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _IosActionSheet(options: options, cancelLabel: cancelLabel);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(0, 0.15),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: child,
        ),
      );
    },
  );
}

class _IosActionSheet extends StatelessWidget {
  const _IosActionSheet({required this.options, required this.cancelLabel});

  final List<IosActionSheetOption> options;
  final String cancelLabel;

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusMd),
            topRight: Radius.circular(AppDimensions.radiusMd),
          ),
          color: theme.backgroundInput,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingLg,
            vertical: AppDimensions.spacingXl,
          ).copyWith(bottom: bottomPadding + AppDimensions.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < options.length; i++) ...[
                      if (i > 0)
                        Divider(
                          height: 1,
                          thickness: 0.5,
                          color: AppColors.buttonTertiaryBorder,
                        ),
                      _ActionSheetTile(
                        theme: theme,
                        label: options[i].label,
                        typography: typography,
                        onPressed: () {
                          Navigator.of(context).pop();
                          options[i].onPressed();
                        },
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Material(
                color: Colors.transparent,
                child: _ActionSheetTile(
                  theme: theme,
                  label: cancelLabel,
                  typography: typography,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionSheetTile extends StatelessWidget {
  const _ActionSheetTile({
    required this.label,
    required this.typography,
    required this.onPressed,
    required this.theme,
  });

  final String label;
  final AppTypographyExtension typography;
  final VoidCallback onPressed;
  final AppThemeExtension theme;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h),
          child: Text(
            label,
            style: typography.bodyMedium16,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
