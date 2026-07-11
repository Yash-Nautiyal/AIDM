import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/dialog/app_system_dialog.dart';
import 'package:aidm/feature/more/presenation/widgets/subscription/show_add_license_sheet.dart';
import 'package:aidm/feature/more/presenation/widgets/subscription/subscription_plan_row.dart';
import 'package:aidm/feature/more/presenation/widgets/subscription/subscription_section_card.dart';
import 'package:flutter/material.dart';

class ManageSubscriptionPage extends StatefulWidget {
  const ManageSubscriptionPage({super.key});

  @override
  State<ManageSubscriptionPage> createState() => _ManageSubscriptionPageState();
}

class _ManageSubscriptionPageState extends State<ManageSubscriptionPage> {
  bool _showBanner = true;

  void _openAddLicense() {
    showAddLicenseSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'Subscription', showBack: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.pagePadding,
                  AppDimensions.spacingVerticalLg,
                  AppDimensions.pagePadding,
                  AppDimensions.spacingVerticalLg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_showBanner) ...[
                      AppSystemDialog(
                        title: "You're all set",
                        description:
                            'You have access to all premium features, including '
                            'unlimited non-concurrent webinars, advanced analytics, '
                            'and priority support.',
                        onClose: () => setState(() => _showBanner = false),
                      ),
                      SizedBox(height: AppDimensions.spacingVerticalLg),
                    ],
                    const SubscriptionSectionCard(
                      title: 'Current Plan',
                      child: SubscriptionPlanRow(
                        title: 'Premium Plan',
                        subtitle: 'Full access to all features',
                        showBadge: true,
                      ),
                    ),
                    SizedBox(height: AppDimensions.spacingVerticalLg),
                    SubscriptionSectionCard(
                      title: 'Your License',
                      trailing: Text(
                        '2 Devices connected',
                        style: typography.body,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      child: SubscriptionPlanRow(
                        title: 'License X 1',
                        licenseLabel: 'INR 0 / comp',
                        licenseStatus: 'active',
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Active',
                              style: typography.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                color: theme.textPrimary,
                              ),
                            ),
                            SizedBox(height: AppDimensions.spacingVerticalXs),
                            Text(
                              'Expired Dec 12, 2026',
                              style: typography.captionLight.copyWith(
                                color: theme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimensions.pagePadding,
                AppDimensions.spacingVerticalSm,
                AppDimensions.pagePadding,
                AppDimensions.spacingVerticalLg,
              ),
              child: AppButton(
                label: 'Add License',
                type: AppButton1Type.secondary,
                onPressed: _openAddLicense,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
