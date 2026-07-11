import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/card/app_bordered_card.dart';
import 'package:aidm/core/widgets/toggle/app_toggle.dart';
import 'package:flutter/material.dart';

class MoreEmailPreferenceSection extends StatefulWidget {
  const MoreEmailPreferenceSection({super.key});

  @override
  State<MoreEmailPreferenceSection> createState() =>
      _MoreEmailPreferenceSectionState();
}

class _MoreEmailPreferenceSectionState
    extends State<MoreEmailPreferenceSection> {
  bool _webinarRemindersEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return AppBorderedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppDimensions.spacingLg,
              AppDimensions.spacingVerticalLg,
              AppDimensions.spacingLg,
              AppDimensions.spacingVerticalMd,
            ),
            child: Text('Email Preference', style: typography.labelLarge),
          ),
          Divider(height: 1, thickness: 1, color: theme.borderDefault),
          Padding(
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
                      Text(
                        'Webinar reminder emails',
                        style: typography.bodyMedium,
                      ),
                      SizedBox(height: AppDimensions.spacingVerticalXs),
                      Text(
                        'Receive reminders when you register for or are '
                        'invited to webinars.',
                        style: typography.captionLight.copyWith(
                          color: theme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: AppDimensions.spacingMd),
                AppToggle(
                  value: _webinarRemindersEnabled,
                  onChanged: (value) {
                    setState(() => _webinarRemindersEnabled = value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
