import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/bottom_sheet/show_app_bottom_sheet.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/button/app_close_button.dart';
import 'package:aidm/core/widgets/card/app_card.dart';
import 'package:aidm/feature/more/presenation/widgets/payment/payment_status_page.dart';
import 'package:flutter/material.dart';

Future<void> showAddLicenseSheet(BuildContext context) {
  return showAppBottomSheet<void>(
    context,
    showHeaderDivider: true,
    header: const _AddLicenseSheetHeader(),
    body: const _AddLicenseSheetBody(),
    footer: const _AddLicenseSheetFooter(),
  );
}

class _AddLicenseSheetHeader extends StatelessWidget {
  const _AddLicenseSheetHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add License',
              style: typography.h2.copyWith(color: theme.brandPrimary),
            ),
            SizedBox(height: AppDimensions.spacingVerticalXs),
            Text(
              'Billed Monthly Cancel anytime',
              style: typography.captionLight.copyWith(
                color: theme.textSecondary,
              ),
            ),
          ],
        ),
        AppCloseButton(onTap: () => moveBack(context)),
      ],
    );
  }
}

class _AddLicenseSheetBody extends StatelessWidget {
  const _AddLicenseSheetBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppCard(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingLg,
            vertical: AppDimensions.spacingVerticalLg,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('License X1', style: typography.labelMedium),
                    SizedBox(height: AppDimensions.spacingVerticalXs),
                    Text(
                      '1 concurrent webinar · 2 devices',
                      style: typography.captionLight.copyWith(
                        color: theme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Expired Dec 1',
                style: typography.captionLight.copyWith(
                  color: theme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.spacingVertical2xl),
        Text('Order Summary', style: typography.labelMedium),
        SizedBox(height: AppDimensions.spacingVerticalMd),
        Divider(height: 1, thickness: 1, color: theme.borderDefault),
        SizedBox(height: AppDimensions.spacingVerticalMd),
        const _OrderSummaryRow(label: 'License X 1', value: 'Rs. 799.00'),
        const _OrderSummaryRow(label: 'GST (18%)', value: 'Rs. 143.22'),
        SizedBox(height: AppDimensions.spacingVerticalMd),
        Divider(height: 1, thickness: 1, color: theme.borderDefault),
        SizedBox(height: AppDimensions.spacingVerticalMd),
        const _OrderSummaryRow(
          label: 'Total Due',
          value: 'Rs. 942.82',
          isTotal: true,
        ),
      ],
    );
  }
}

class _OrderSummaryRow extends StatelessWidget {
  const _OrderSummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    final labelStyle = isTotal
        ? typography.labelMedium
        : typography.bodyMedium.copyWith(color: theme.textSecondary);

    final valueStyle = isTotal ? typography.labelMedium : typography.bodyMedium;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.spacingVerticalXs),
      child: Row(
        children: [
          Expanded(child: Text(label, style: labelStyle)),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}

class _AddLicenseSheetFooter extends StatelessWidget {
  const _AddLicenseSheetFooter();

  void _onContinue(BuildContext context) {
    moveBack(context);
    moveTo(context, const PaymentStatusPage(status: PaymentStatus.success));
  }

  @override
  Widget build(BuildContext context) {
    return AppButton(label: 'Continue', onPressed: () => _onContinue(context));
  }
}
