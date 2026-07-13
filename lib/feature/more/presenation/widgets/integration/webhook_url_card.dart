import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/card/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WebhookUrlCard extends StatelessWidget {
  const WebhookUrlCard({
    super.key,
    required this.url,
    this.onOpenDocs,
  });

  final String url;
  final VoidCallback? onOpenDocs;

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: url));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Webhook URL copied')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return AppCard(
      padding: EdgeInsets.all(AppDimensions.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Webhook callback URL',
            style: typography.labelLarge.copyWith(color: theme.textPrimary),
          ),
          SizedBox(height: AppDimensions.spacingVerticalMd),
          Text(
            'We will POST event payloads to this URL '
            '(e.g. webinar.recording.created).',
            style: typography.captionLight.copyWith(color: theme.textSecondary),
          ),
          SizedBox(height: AppDimensions.spacingVerticalLg),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingMd,
                    vertical: AppDimensions.spacingVerticalMd,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                    border: Border.all(color: theme.borderDefault),
                  ),
                  child: Text(
                    url,
                    style: typography.bodyMedium.copyWith(
                      color: theme.brandPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(width: AppDimensions.spacingSm),
              AppButton(
                label: 'Copy',
                expand: false,
                height: AppDimensions.buttonHeightMd,
                onPressed: () => _copy(context),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.spacingVerticalLg),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: onOpenDocs,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.spacingVerticalXs,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.north_east_rounded,
                      size: AppDimensions.iconSizeMd,
                      color: theme.brandPrimary,
                    ),
                    SizedBox(width: AppDimensions.spacingXs),
                    Text(
                      'API & Integration docs',
                      style: typography.bodyMedium.copyWith(
                        color: theme.brandPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
