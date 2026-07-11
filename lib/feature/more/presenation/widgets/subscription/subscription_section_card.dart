import 'package:flutter/material.dart';

import '../../../../../core/constant/app_dimensions.dart';
import '../../../../../core/theme/app_theme_extension.dart';
import '../../../../../core/theme/typography/app_typography_extension.dart';
import '../../../../../core/widgets/card/app_card.dart';

class SubscriptionSectionCard extends StatelessWidget {
  const SubscriptionSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return AppCard(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.spacingLg,
        AppDimensions.spacingVerticalLg,
        AppDimensions.spacingLg,
        AppDimensions.spacingVerticalSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: typography.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing ?? const SizedBox.shrink(),
            ],
          ),
          SizedBox(height: AppDimensions.spacingVerticalMd),
          Divider(height: 1, thickness: 1, color: theme.borderDefault),
          child,
        ],
      ),
    );
  }
}
