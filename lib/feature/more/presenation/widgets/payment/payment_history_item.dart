import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:flutter/material.dart';

import '../subscription/subscription_shared_widgets.dart';
import 'payment_history_page.dart';

class PaymentHistoryItem extends StatelessWidget {
  const PaymentHistoryItem({super.key, required this.entry});

  final PaymentHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(entry.date, style: typography.labelLarge)),
            Text(entry.amount, style: typography.labelLarge),
          ],
        ),
        SizedBox(height: AppDimensions.spacingVerticalMd),
        SubscriptionKeyValueRow(
          label: 'Payment Mode',
          value: entry.paymentMode,
        ),
        SubscriptionKeyValueRow(label: 'Payment ID', value: entry.paymentId),
        SubscriptionKeyValueRow(
          label: 'Next billing',
          value: entry.nextBilling,
        ),
      ],
    );
  }
}
