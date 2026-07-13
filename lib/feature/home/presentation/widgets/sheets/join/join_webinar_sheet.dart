import 'package:aidm/core/widgets/input/app_input2.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constant/app_dimensions.dart';
import '../../../../../../core/theme/typography/app_typography_extension.dart';
import '../../../../../../core/widgets/bottom_sheet/app_bottom_sheet.dart';
import '../../../../../../core/widgets/bottom_sheet/show_app_bottom_sheet.dart';

Future<void> showJointWebinarSheet(BuildContext context) {
  return showAppBottomSheet<void>(
    context,
    header: const AppBottomSheetHeader(title: 'Join Webinar'),
    body: const _JoinWebinarSheet(),
    showFooterButton: true,
    footerButtonLabel: 'Join Now',
    onFooterButtonPressed: () => {
      // TODO: Implement join webinar logic
    },
  );
}

class _JoinWebinarSheet extends StatefulWidget {
  const _JoinWebinarSheet();

  @override
  State<_JoinWebinarSheet> createState() => _JoinWebinarSheetState();
}

class _JoinWebinarSheetState extends State<_JoinWebinarSheet> {
  final _webinarIdController = TextEditingController();

  @override
  void dispose() {
    _webinarIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Enter the Webinar ID to join', style: typography.labelLarge),
        SizedBox(height: AppDimensions.spacingVerticalMd),
        AppInput2(
          controller: _webinarIdController,
          hintText: 'Enter Webinar ID',
          showBorder: true,
        ),
      ],
    );
  }
}
