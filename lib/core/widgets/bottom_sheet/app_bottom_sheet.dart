import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    this.header,
    required this.body,
    this.footer,
    this.showHeaderDivider = true,
    this.showFooterDivider = false,
    this.scrollBody = false,
    this.padding,
  });

  final Widget? header;
  final Widget body;
  final Widget? footer;
  final bool showHeaderDivider;
  final bool showFooterDivider;
  final bool scrollBody;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.92;
    final contentPadding =
        padding ??
        EdgeInsets.symmetric(horizontal: AppDimensions.pagePadding).copyWith(
          top: AppDimensions.spacingVerticalLg,
          bottom: AppDimensions.spacingVertical2xl,
        );

    final bodyWidget = scrollBody
        ? Flexible(
            child: SingleChildScrollView(padding: EdgeInsets.zero, child: body),
          )
        : body;

    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomInset,
        top: AppDimensions.spacingVerticalLg,
      ),
      child: Material(
        color: theme.backgroundPage,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radius3xl),
        ),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: Padding(
              padding: contentPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (header != null) ...[
                    header!,
                    SizedBox(height: AppDimensions.spacingVerticalMd),
                    if (showHeaderDivider) ...[
                      Divider(height: 1, color: theme.borderDefault),
                      SizedBox(height: AppDimensions.spacingVerticalXl),
                    ],
                  ],
                  bodyWidget,
                  if (footer != null) ...[
                    if (showFooterDivider) ...[
                      SizedBox(height: AppDimensions.spacingVerticalMd),
                      Divider(height: 1, color: theme.borderDefault),
                    ],
                    SizedBox(height: AppDimensions.spacingVertical2xl),
                    footer!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppBottomSheetHeader extends StatelessWidget {
  const AppBottomSheetHeader({
    super.key,
    required this.title,
    this.onClose,
    this.trailing,
  });

  final String title;
  final VoidCallback? onClose;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.spacingVerticalMd),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: typography.h2.copyWith(color: theme.brandPrimary),
            textAlign: TextAlign.center,
          ),
          Align(
            alignment: Alignment.centerRight,
            child:
                trailing ??
                _CloseButton(
                  onClose: onClose ?? () => Navigator.of(context).pop(),
                ),
          ),
        ],
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Material(
      color: theme.backgroundInput,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onClose,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spacingSm),
          child: SvgPicture.asset(
            AppAssets.closeIcon,
            width: AppDimensions.iconSizehSm,
            colorFilter: ColorFilter.mode(theme.textSecondary, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
