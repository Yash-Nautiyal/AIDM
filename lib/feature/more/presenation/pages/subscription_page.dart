import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/feature/more/presenation/widgets/subscription/manage_subscription_page.dart';
import 'package:aidm/feature/more/presenation/widgets/payment/payment_history_page.dart';
import 'package:aidm/feature/more/presenation/widgets/subscription/show_add_license_sheet.dart';
import 'package:aidm/feature/more/presenation/widgets/subscription/subscription_menu_row.dart';
import 'package:aidm/feature/more/presenation/widgets/subscription/subscription_plan_row.dart';
import 'package:aidm/feature/more/presenation/widgets/subscription/subscription_section_card.dart';
import 'package:aidm/feature/more/presenation/widgets/subscription/subscription_shared_widgets.dart';
import 'package:flutter/material.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  void _openPaymentHistory(BuildContext context) {
    moveTo(context, const PaymentHistoryPage());
  }

  void _openManageSubscription(BuildContext context) {
    moveTo(context, const ManageSubscriptionPage());
  }

  void _openAddLicense(BuildContext context) {
    showAddLicenseSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'Subscription', showBack: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: AppDimensions.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                      title: 'Billing Info',
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: AppDimensions.spacingVerticalSm,
                          bottom: AppDimensions.spacingVerticalLg,
                        ),
                        child: Column(
                          children: [
                            const SubscriptionKeyValueRow(
                              label: 'Status',
                              value: 'Active',
                            ),
                            const SubscriptionKeyValueRow(
                              label: 'Started',
                              value: 'June 15, 2026',
                            ),
                            const SubscriptionKeyValueRow(
                              label: 'Next billing',
                              value: 'December 12, 2026',
                            ),
                            SizedBox(height: AppDimensions.spacingVerticalLg),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: theme.borderDefault,
                            ),
                            SubscriptionMenuRow(
                              title: 'Payment History',
                              onTap: () => _openPaymentHistory(context),
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
              padding: AppDimensions.pagePadding,
              child: Column(
                children: [
                  AppButton(
                    label: 'Manage Subscription',
                    type: AppButton1Type.secondary,
                    onPressed: () => _openManageSubscription(context),
                  ),
                  SizedBox(height: AppDimensions.spacingVerticalMd),
                  AppButton(
                    label: 'Add License',
                    onPressed: () => _openAddLicense(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
