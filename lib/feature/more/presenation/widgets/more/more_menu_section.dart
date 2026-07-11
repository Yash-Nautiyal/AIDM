import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/card/app_bordered_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

sealed class MoreMenuItem {
  const MoreMenuItem({required this.title, this.onTap, this.iconSize});

  final String title;
  final VoidCallback? onTap;
  final double? iconSize;
}

class MoreMenuIconItem extends MoreMenuItem {
  const MoreMenuIconItem({
    required super.title,
    required this.icon,
    super.onTap,
    super.iconSize,
  });

  final IconData icon;
}

class MoreMenuSvgItem extends MoreMenuItem {
  const MoreMenuSvgItem({
    required super.title,
    required this.assetPath,
    super.onTap,
    super.iconSize,
  });

  final String assetPath;
}

class MoreMenuSection extends StatelessWidget {
  const MoreMenuSection({super.key, required this.items});

  final List<MoreMenuItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return AppBorderedCard(
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              _MoreMenuRow(item: item),
              if (index != items.length - 1)
                Divider(height: 1, thickness: 1, color: theme.borderDefault),
            ],
          );
        }),
      ),
    );
  }
}

class _MoreMenuRow extends StatelessWidget {
  const _MoreMenuRow({required this.item});

  final MoreMenuItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingLg,
            vertical: AppDimensions.spacingVerticalLg,
          ),
          child: Row(
            children: [
              _MenuIcon(item: item, theme: theme),
              SizedBox(width: AppDimensions.spacingMd),
              Expanded(
                child: Text(
                  item.title,
                  style: typography.bodyMedium.copyWith(
                    color: theme.textPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.textSecondary,
                size: AppDimensions.iconSizeLg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuIcon extends StatelessWidget {
  const _MenuIcon({required this.item, required this.theme});

  final MoreMenuItem item;
  final AppThemeExtension theme;

  @override
  Widget build(BuildContext context) {
    return switch (item) {
      MoreMenuSvgItem(:final assetPath) => SvgPicture.asset(
        assetPath,
        width: item.iconSize ?? AppDimensions.iconSizeMd,
        height: item.iconSize ?? AppDimensions.iconSizeMd,
        colorFilter: ColorFilter.mode(theme.textPrimary, BlendMode.srcIn),
      ),
      MoreMenuIconItem(:final icon) => Icon(
        icon,
        color: theme.textPrimary,
        size: item.iconSize ?? AppDimensions.iconSizeMd,
      ),
    };
  }
}
