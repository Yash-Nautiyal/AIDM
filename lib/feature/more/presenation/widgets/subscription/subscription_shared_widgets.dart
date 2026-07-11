import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:flutter/material.dart';

class SubscriptionKeyValueRow extends StatelessWidget {
  const SubscriptionKeyValueRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.spacingVerticalXs),
      child: Row(
        children: [
          Expanded(child: Text(label, style: typography.bodyCompact)),
          Text(
            value,
            style: typography.bodyCompact.copyWith(color: theme.textSecondary),
          ),
        ],
      ),
    );
  }
}
