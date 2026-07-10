import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:aidm/core/widgets/bottom_sheet/show_app_bottom_sheet.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/input/app_input2.dart';
import 'package:flutter/material.dart';

Future<String?> showWebinarTitleEditSheet(
  BuildContext context, {
  required String initialTitle,
}) {
  return showAppBottomSheet<String>(
    context,
    header: const AppBottomSheetHeader(title: 'Edit Webinar'),
    body: _WebinarTitleEditSheet(initialTitle: initialTitle),
  );
}

class _WebinarTitleEditSheet extends StatefulWidget {
  const _WebinarTitleEditSheet({required this.initialTitle});

  final String initialTitle;

  @override
  State<_WebinarTitleEditSheet> createState() => _WebinarTitleEditSheetState();
}

class _WebinarTitleEditSheetState extends State<_WebinarTitleEditSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTitle);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _canSave {
    final value = _controller.text.trim();
    return value.isNotEmpty && value != widget.initialTitle;
  }

  void _save() {
    final value = _controller.text.trim();
    if (!_canSave) return;
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Webinar Title',
          style: typography.bodyMedium.copyWith(color: theme.textSecondary),
        ),
        SizedBox(height: AppDimensions.spacingSm),
        AppInput2(
          controller: _controller,
          hintText: 'e.g. Demo Webinar',
          showBorder: true,
        ),
        SizedBox(height: AppDimensions.spacingVerticalLg),
        AppButton(
          label: 'Update',
          enabled: _canSave,
          onPressed: _canSave ? _save : null,
        ),
      ],
    );
  }
}
