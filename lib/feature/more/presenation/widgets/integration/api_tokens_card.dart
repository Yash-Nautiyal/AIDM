import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/card/app_card.dart';
import 'package:flutter/material.dart';

class ApiTokensCard extends StatelessWidget {
  const ApiTokensCard({
    super.key,
    required this.token,
    required this.onCreateToken,
  });

  final String? token;
  final VoidCallback onCreateToken;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return AppCard(
      padding: EdgeInsets.all(AppDimensions.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'API Tokens',
                  style: typography.labelLarge.copyWith(
                    color: theme.textPrimary,
                  ),
                ),
              ),
              AppButton(
                label: 'Create Token',
                expand: false,
                height: AppDimensions.buttonHeightMd,
                onPressed: onCreateToken,
              ),
            ],
          ),
          SizedBox(height: AppDimensions.spacingVerticalMd),
          Text(
            'Use tokens to authenticate API requests. Keep them secret. '
            'Only one token is allowed at a time.',
            style: typography.captionLight.copyWith(color: theme.textSecondary),
          ),
          SizedBox(height: AppDimensions.spacingVerticalLg),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingLg,
              vertical: AppDimensions.spacingVertical2xl,
            ),
            decoration: BoxDecoration(
              color: theme.backgroundInput,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              border: Border.all(color: theme.borderDefault),
            ),
            child: token == null
                ? Text(
                    'No API Tokens Yet',
                    textAlign: TextAlign.center,
                    style: typography.bodyMedium.copyWith(
                      color: theme.textTertiary,
                    ),
                  )
                : Text(
                    token!,
                    textAlign: TextAlign.center,
                    style: typography.bodyMedium.copyWith(
                      color: theme.textPrimary,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
