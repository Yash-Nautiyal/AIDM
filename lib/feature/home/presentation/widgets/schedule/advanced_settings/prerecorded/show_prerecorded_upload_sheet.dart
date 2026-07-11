import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/bottom_sheet/show_app_bottom_sheet.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> showPrerecordedUploadSheet(BuildContext context) async {
  return showAppBottomSheet<String>(
    context,
    showHeaderDivider: false,
    body: const _PrerecordedUploadSheet(),
  );
}

class _PrerecordedUploadSheet extends StatefulWidget {
  const _PrerecordedUploadSheet();

  @override
  State<_PrerecordedUploadSheet> createState() =>
      _PrerecordedUploadSheetState();
}

class _PrerecordedUploadSheetState extends State<_PrerecordedUploadSheet> {
  final _picker = ImagePicker();
  bool _isPicking = false;

  Future<void> _pickVideo() async {
    if (_isPicking) return;
    setState(() => _isPicking = true);
    try {
      final file = await _picker.pickVideo(source: ImageSource.gallery);
      if (!mounted || file == null) return;
      moveBack(context, file.name);
    } finally {
      if (mounted) setState(() => _isPicking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Upload MP4',
          style: typography.h3.copyWith(color: theme.textPrimary),
        ),
        SizedBox(height: AppDimensions.spacingVerticalLg),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingLg,
            vertical: AppDimensions.spacingVertical2xl,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            border: Border.all(color: theme.borderDefault),
          ),
          child: Column(
            children: [
              Text(
                'MP4, VIDEO/MP4 files only',
                style: typography.bodyMedium.copyWith(color: theme.textPrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.spacingVerticalXs),
              Text(
                'Max size: 2 GB',
                style: typography.captionLight.copyWith(
                  color: theme.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.spacingVerticalLg),
              AppButton(
                label: 'Upload',
                type: AppButton1Type.secondary,
                isLoading: _isPicking,
                onPressed: _pickVideo,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
