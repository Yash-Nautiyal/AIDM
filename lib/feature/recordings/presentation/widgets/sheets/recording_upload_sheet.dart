import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:aidm/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:aidm/core/widgets/bottom_sheet/show_app_bottom_sheet.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/input/app_input2.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> showRecordingUploadSheet(BuildContext context) {
  return showAppBottomSheet<String>(
    context,
    showHeaderDivider: false,
    header: const AppBottomSheetHeader(title: 'Recordings'),
    body: const _RecordingUploadSheetBody(),
  );
}

class _RecordingUploadSheetBody extends StatefulWidget {
  const _RecordingUploadSheetBody();

  @override
  State<_RecordingUploadSheetBody> createState() =>
      _RecordingUploadSheetBodyState();
}

class _RecordingUploadSheetBodyState extends State<_RecordingUploadSheetBody> {
  final _titleController = TextEditingController();
  final _picker = ImagePicker();
  String? _selectedFileName;
  bool _isPicking = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_onTitleChanged);
  }

  @override
  void dispose() {
    _titleController.removeListener(_onTitleChanged);
    _titleController.dispose();
    super.dispose();
  }

  void _onTitleChanged() => setState(() {});

  Future<void> _pickVideo() async {
    if (_isPicking) return;
    setState(() => _isPicking = true);
    try {
      final file = await _picker.pickVideo(source: ImageSource.gallery);
      if (!mounted || file == null) return;
      setState(() => _selectedFileName = file.name);
    } finally {
      if (mounted) setState(() => _isPicking = false);
    }
  }

  void _upload() {
    final title = _titleController.text.trim();
    if (title.isEmpty || _selectedFileName == null) return;
    moveBack(context, title);
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
          'Title',
          style: typography.bodyMedium.copyWith(color: theme.textSecondary),
        ),
        SizedBox(height: AppDimensions.spacingSm),
        AppInput2(
          controller: _titleController,
          hintText: 'e.g. Demo',
          showBorder: true,
        ),
        SizedBox(height: AppDimensions.spacingVerticalLg),
        Text(
          'File',
          style: typography.bodyMedium.copyWith(color: theme.textSecondary),
        ),
        SizedBox(height: AppDimensions.spacingSm),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _isPicking ? null : _pickVideo,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            child: Ink(
              padding: EdgeInsets.symmetric(
                vertical: AppDimensions.spacingVertical2xl,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                border: Border.all(color: theme.borderDefault),
              ),
              child: Column(
                children: [
                  Container(
                    width: 48.sp,
                    height: 48.sp,
                    decoration: BoxDecoration(
                      color: theme.brandPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: _isPicking
                        ? Padding(
                            padding: EdgeInsets.all(AppDimensions.spacingMd),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: theme.brandPrimaryTint,
                            ),
                          )
                        : Icon(
                            Icons.file_upload_outlined,
                            color: theme.brandPrimaryTint,
                            size: 24.sp,
                          ),
                  ),
                  SizedBox(height: AppDimensions.spacingVerticalMd),
                  Text(
                    _selectedFileName ?? 'Tap to Upload file',
                    style: typography.bodyMedium.copyWith(
                      color: _selectedFileName != null
                          ? theme.textPrimary
                          : theme.textTertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppDimensions.spacingVerticalXs),
                  Text(
                    'MP4, VIDEO/MP4 files only',
                    style: typography.captionLight.copyWith(
                      color: theme.textTertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: AppDimensions.spacingVerticalLg),
        AppButton(
          label: 'Upload',
          onPressed: _canUpload ? _upload : null,
          enabled: _canUpload,
        ),
      ],
    );
  }

  bool get _canUpload =>
      _selectedFileName != null && _titleController.text.trim().isNotEmpty;
}
