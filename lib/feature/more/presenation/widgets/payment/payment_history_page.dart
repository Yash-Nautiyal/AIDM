import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:flutter/material.dart';

import '../subscription/subscription_plan_row.dart';
import '../subscription/subscription_section_card.dart';
import 'payment_history_item.dart';

class PaymentHistoryEntry {
  const PaymentHistoryEntry({
    required this.date,
    required this.amount,
    required this.paymentMode,
    required this.paymentId,
    required this.nextBilling,
  });

  final String date;
  final String amount;
  final String paymentMode;
  final String paymentId;
  final String nextBilling;
}

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({super.key});

  static const _entries = [
    PaymentHistoryEntry(
      date: 'June 12, 2026',
      amount: '₹799',
      paymentMode: 'Debit Card',
      paymentId: 'PLJ7930',
      nextBilling: 'July 12, 2026',
    ),
    PaymentHistoryEntry(
      date: 'May 12, 2026',
      amount: '₹799',
      paymentMode: 'Debit Card',
      paymentId: 'PLJ7930',
      nextBilling: 'June 12, 2026',
    ),
    PaymentHistoryEntry(
      date: 'April 12, 2026',
      amount: '₹799',
      paymentMode: 'Debit Card',
      paymentId: 'PLJ7930',
      nextBilling: 'May 12, 2026',
    ),
    PaymentHistoryEntry(
      date: 'April 12, 2026',
      amount: '₹799',
      paymentMode: 'Debit Card',
      paymentId: 'PLJ7930',
      nextBilling: 'May 12, 2026',
    ),
    PaymentHistoryEntry(
      date: 'April 12, 2026',
      amount: '₹799',
      paymentMode: 'Debit Card',
      paymentId: 'PLJ7930',
      nextBilling: 'May 12, 2026',
    ),
    PaymentHistoryEntry(
      date: 'April 12, 2026',
      amount: '₹799',
      paymentMode: 'Debit Card',
      paymentId: 'PLJ7930',
      nextBilling: 'May 12, 2026',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'Payment History', showBack: true),
      body: SafeArea(
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
                ),
              ),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              Text('Payment History', style: typography.labelLarge),
              SizedBox(height: AppDimensions.spacingVerticalLg),
              Divider(height: 1, thickness: 1, color: theme.borderDefault),
              SizedBox(height: AppDimensions.spacingVerticalMd),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                  final entry = _entries[index];
                  return Column(
                    children: [
                      if (index > 0)
                        Divider(
                          height: AppDimensions.spacingVerticalLg * 2,
                          thickness: 1,
                          color: theme.borderDefault,
                        ),
                      PaymentHistoryItem(entry: entry),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
