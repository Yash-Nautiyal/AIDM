import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:flutter/material.dart';

class SlidingPageLayout extends StatelessWidget {
  const SlidingPageLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.illustration,
    required this.actions,
    this.footer,
  });

  final String title;
  final String subtitle;
  final Widget illustration;
  final Widget? footer;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.pagePadding,
      ).copyWith(top: AppDimensions.spacing3xl),
      child: Column(
        children: [
          SizedBox(height: AppDimensions.spacing3xl),
          Text(
            title,
            style: typography.h1.copyWith(color: theme.brandPrimary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimensions.spacingMd),
          Text(
            subtitle,
            style: typography.body.copyWith(color: theme.textSecondary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimensions.spacing3xl),
          Center(child: illustration),
          SizedBox(height: AppDimensions.spacing2xl),
          if (footer != null) ...[
            footer!,
            SizedBox(height: AppDimensions.spacingLg),
          ],
          ...actions.expand(
            (action) => [action, SizedBox(height: AppDimensions.spacingMd)],
          ),
          SizedBox(height: AppDimensions.spacingLg),
        ],
      ),
    );
  }
}
