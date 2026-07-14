import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/card/app_card.dart';
import 'package:aidm/feature/more/presenation/widgets/subscription/subscription_shared_widgets.dart';
import 'package:flutter/material.dart';

enum PaymentStatus { success, failed }

class PaymentStatusPage extends StatelessWidget {
  const PaymentStatusPage({
    super.key,
    required this.status,
    this.refNumber = 'idwjeri9023nkdfkls',
    this.paymentTime = 'December 12, 2026 12:10PM',
  });

  final PaymentStatus status;
  final String refNumber;
  final String paymentTime;

  bool get _isSuccess => status == PaymentStatus.success;

  String get _statusLabel => _isSuccess ? 'Success' : 'Failed';

  String get _headline =>
      _isSuccess ? 'Payment Successful!' : 'Payment Failed!';

  void _onDone(BuildContext context) {
    moveBack(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final accentColor = _isSuccess ? theme.brandPrimary : theme.textDanger;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'Payment Success', showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.pagePadding,
          child: Column(
            children: [
              _PaymentStatusIcon(isSuccess: _isSuccess, color: accentColor),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              Text(
                _headline,
                style: typography.h3.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppDimensions.spacingLg,
                        AppDimensions.spacingLg,
                        AppDimensions.spacingLg,
                        AppDimensions.spacingMd,
                      ),
                      child: Text(
                        'Payment Details',
                        style: typography.labelLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.textPrimary,
                        ),
                      ),
                    ),
                    Divider(height: 1, thickness: 1, color: theme.borderDefault),
                    Padding(
                      padding: EdgeInsets.all(AppDimensions.spacingLg),
                      child: Column(
                        children: [
                          SubscriptionKeyValueRow(
                            label: 'Ref Number',
                            value: refNumber,
                          ),
                          SubscriptionKeyValueRow(
                            label: 'Payment Status',
                            value: _statusLabel,
                          ),
                          SubscriptionKeyValueRow(
                            label: 'Payment Time',
                            value: paymentTime,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppDimensions.spacingVertical3xl),
              AppButton(label: 'Done', onPressed: () => _onDone(context)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentStatusIcon extends StatelessWidget {
  const _PaymentStatusIcon({required this.isSuccess, required this.color});

  final bool isSuccess;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final outerSize = 120.sp;
    final innerSize = 72.sp;

    return SizedBox(
      width: outerSize,
      height: outerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: outerSize,
            height: outerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.12),
            ),
          ),
          Container(
            width: innerSize,
            height: innerSize,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Icon(
              isSuccess ? Icons.check_rounded : Icons.close_rounded,
              color: theme.brandPrimaryTint,
              size: 36.sp,
            ),
          ),
        ],
      ),
    );
  }
}
