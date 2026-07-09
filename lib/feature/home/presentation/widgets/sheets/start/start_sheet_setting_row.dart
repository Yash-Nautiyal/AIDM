import 'package:flutter/material.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/constant/app_dimensions.dart';

class StartSheetSettingsRow extends StatelessWidget {
  const StartSheetSettingsRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    final content = Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.spacingVerticalLg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: typography.bodyMedium.copyWith(
                    color: theme.textPrimary,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: AppDimensions.spacingVerticalXs),
                  Text(
                    subtitle,
                    style: typography.captionLight.copyWith(
                      color: theme.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          trailing,
        ],
      ),
    );

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      child: InkWell(onTap: onTap, child: content),
    );
  }
}
