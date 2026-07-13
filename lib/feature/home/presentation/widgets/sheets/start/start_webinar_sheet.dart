import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:aidm/core/widgets/bottom_sheet/show_app_bottom_sheet.dart';
import 'package:aidm/core/widgets/input/app_input2.dart';
import 'package:aidm/core/widgets/toggle/app_toggle.dart';
import 'package:flutter/material.dart';

import 'start_sheet_privacy.dart';
import 'start_sheet_setting_row.dart';

enum WebinarPrivacy { public, private }

Future<void> showStartWebinarSheet(BuildContext context) {
  return showAppBottomSheet<void>(
    context,
    header: const AppBottomSheetHeader(title: 'Start Webinar'),
    body: const _StartWebinarSheet(),
    showFooterButton: true,
    footerButtonLabel: 'Start Now',
    onFooterButtonPressed: () => {
      // TODO: Implement start webinar logic
    },
  );
}

class _StartWebinarSheet extends StatefulWidget {
  const _StartWebinarSheet();

  @override
  State<_StartWebinarSheet> createState() => _StartWebinarSheetState();
}

class _StartWebinarSheetState extends State<_StartWebinarSheet> {
  final _titleController = TextEditingController();
  WebinarPrivacy _privacy = WebinarPrivacy.public;
  bool _autoRecord = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Webinar Title', style: typography.labelLarge),
        SizedBox(height: AppDimensions.spacingVerticalSm),
        AppInput2(
          showBorder: true,
          controller: _titleController,
          hintText: 'e.g. How to grow your audience',
        ),
        SizedBox(height: AppDimensions.spacingVertical2xl),
        Text('Privacy', style: typography.labelLarge),
        SizedBox(height: AppDimensions.spacingVerticalSm),
        Row(
          children: [
            Expanded(
              child: StartSheetPrivacy(
                label: 'Public',
                subtitle: 'Anyone can join',
                isSelected: _privacy == WebinarPrivacy.public,
                onTap: () => setState(() => _privacy = WebinarPrivacy.public),
              ),
            ),
            SizedBox(width: AppDimensions.spacingMd),
            Expanded(
              child: StartSheetPrivacy(
                label: 'Private',
                subtitle: 'Invite only',
                isSelected: _privacy == WebinarPrivacy.private,
                onTap: () => setState(() => _privacy = WebinarPrivacy.private),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.spacingVerticalSm),
        Text(
          _privacy == WebinarPrivacy.public
              ? 'Anyone with the link can join'
              : 'Only invited participants can join',
          style: typography.captionLight.copyWith(color: theme.textSecondary),
        ),
        SizedBox(height: AppDimensions.spacingVertical2xl),
        Divider(height: 1, color: theme.borderDefault),
        StartSheetSettingsRow(
          title: 'Schedule for later',
          subtitle: 'Start immediately or pick a date & time',
          trailing: Icon(
            Icons.chevron_right_rounded,
            color: theme.textTertiary,
          ),
          onTap: () {},
        ),
        Divider(height: 1, color: theme.borderDefault),
        StartSheetSettingsRow(
          title: 'Auto Record',
          subtitle: 'Save recording after session ends',
          trailing: AppToggle(
            value: _autoRecord,
            onChanged: (value) => setState(() => _autoRecord = value),
          ),
        ),
      ],
    );
  }
}
