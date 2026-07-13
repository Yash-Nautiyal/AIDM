import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_colors.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/card/app_card.dart';
import 'package:aidm/core/widgets/nav/app_shell.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/app_assets.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  static const _features = [
    'Unlimited Capacity (1K to 1M attendees)',
    'HD Cloud Streams crystal clear, low latency',
    'Host Controls: Q&A, polls & sharing',
    'Built-in Analytics & engagement reports',
    'Recording & instant replay sharing',
    'Custom branding & domain',
    'Priority support',
  ];

  void _goToDashboard(BuildContext context) {
    moveTo(context, const AppShell(key: Key('app_shell')), clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      body: SafeArea(
        child: Padding(
          padding: AppDimensions.pagePadding,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: AppDimensions.spacing3xl),
                  child: Column(
                    children: [
                      Text(
                        'Premium performance,\nunbeatable pricing.',
                        style: typography.h2.copyWith(
                          color: theme.brandPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppDimensions.spacingMd),
                      Text(
                        'Scale your audience without scaling your budget. '
                        'Experience high-end broadcasting with a transparent model.',
                        style: typography.bodyMedium.copyWith(
                          color: theme.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppDimensions.spacing2xl),
                      _PricingCard(
                        theme: theme,
                        typography: typography,
                        features: _features,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: AppDimensions.spacingLg,
                  bottom: AppDimensions.spacingLg,
                ),
                child: Column(
                  children: [
                    AppButton(
                      label: 'Get Started',
                      onPressed: () => _goToDashboard(context),
                    ),
                    SizedBox(height: AppDimensions.spacingMd),
                    GestureDetector(
                      onTap: () => _goToDashboard(context),
                      child: Text(
                        'Skip for now',
                        style: typography.bodyMedium.copyWith(
                          color: theme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  const _PricingCard({
    required this.theme,
    required this.typography,
    required this.features,
  });

  final AppThemeExtension theme;
  final AppTypographyExtension typography;
  final List<String> features;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '₹799',
                        style: typography.display.copyWith(
                          color: theme.textPrimary,
                        ),
                      ),
                      TextSpan(
                        text: ' /month',
                        style: typography.bodyMedium.copyWith(
                          color: theme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset(
                AppAssets.premiumImg,
                width: 22.w,
                height: 22.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
          SizedBox(height: AppDimensions.spacingSm),
          Text(
            'webinar.gg Pro',
            style: typography.h3.copyWith(color: theme.brandPrimary),
          ),
          SizedBox(height: AppDimensions.spacingSm),
          Text(
            'Unlimited broadcasting at a flat rate. HD streams, host '
            'controls, and analytics no hidden fees.',
            style: typography.body.copyWith(color: theme.textSecondary),
          ),
          SizedBox(height: AppDimensions.spacingLg),
          Text(
            'What you get',
            style: typography.label.copyWith(color: theme.textPrimary),
          ),
          SizedBox(height: AppDimensions.spacingSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppDimensions.spacingMd),
            decoration: BoxDecoration(
              color: theme.brandPurpleTint,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => _FeatureRow(
                label: features[index],
                theme: theme,
                typography: typography,
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppDimensions.spacingMd),
              itemCount: features.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.label,
    required this.theme,
    required this.typography,
  });

  final String label;
  final AppThemeExtension theme;
  final AppTypographyExtension typography;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 22.w,
          height: 22.w,
          decoration: BoxDecoration(
            color: theme.brandPrimary,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, size: 15.sp, color: theme.brandPrimaryTint),
        ),
        SizedBox(width: AppDimensions.spacingSm),
        Expanded(
          child: Text(
            label,
            style: typography.caption.copyWith(color: AppColors.darkBgInput),
          ),
        ),
      ],
    );
  }
}
