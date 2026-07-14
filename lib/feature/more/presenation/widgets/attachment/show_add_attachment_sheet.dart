import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:aidm/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:aidm/core/widgets/bottom_sheet/show_app_bottom_sheet.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/input/app_input2.dart';
import 'package:aidm/feature/more/presenation/widgets/attachment/attachment_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddAttachmentResult {
  const AddAttachmentResult({required this.title, required this.fileName});

  final String title;
  final String fileName;
}

Future<AddAttachmentResult?> showAddAttachmentSheet(
  BuildContext context, {
  String? initialTitle,
  String? initialFileName,
  bool isEditing = false,
}) {
  return showAppBottomSheet<AddAttachmentResult>(
    context,
    showHeaderDivider: true,
    header: AppBottomSheetHeader(
      title: isEditing ? 'Edit Attachment' : 'Add Attachments',
    ),
    body: _AddAttachmentSheetBody(
      initialTitle: initialTitle,
      initialFileName: initialFileName,
      isEditing: isEditing,
    ),
  );
}

class _AddAttachmentSheetBody extends StatefulWidget {
  const _AddAttachmentSheetBody({
    this.initialTitle,
    this.initialFileName,
    this.isEditing = false,
  });

  final String? initialTitle;
  final String? initialFileName;
  final bool isEditing;

  @override
  State<_AddAttachmentSheetBody> createState() =>
      _AddAttachmentSheetBodyState();
}

class _AddAttachmentSheetBodyState extends State<_AddAttachmentSheetBody> {
  late final TextEditingController _titleController;
  String? _selectedFileName;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _selectedFileName = widget.initialFileName;
    _titleController.addListener(_onChanged);
  }

  @override
  void dispose() {
    _titleController.removeListener(_onChanged);
    _titleController.dispose();
    super.dispose();
  }

  void _onChanged() => setState(() {});

  void _pickFile() {
    // UI-only selection until a document picker is wired.
    setState(() => _selectedFileName = 'SlideDeck.pdf');
  }

  void _upload() {
    final title = _titleController.text.trim();
    final fileName = _selectedFileName;
    if (title.isEmpty || fileName == null) return;
    moveBack(context, AddAttachmentResult(title: title, fileName: fileName));
  }

  bool get _canUpload =>
      _selectedFileName != null && _titleController.text.trim().isNotEmpty;

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
          hintText: 'e.g. Slide deck',
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
            onTap: _pickFile,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            child: Ink(
              padding: EdgeInsets.symmetric(
                vertical: AppDimensions.spacingVertical2xl,
                horizontal: AppDimensions.spacingLg,
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
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.uploadIcon,
                        width: 20.sp,
                        height: 20.sp,
                        colorFilter: ColorFilter.mode(
                          theme.brandPrimaryTint,
                          BlendMode.srcIn,
                        ),
                      ),
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
                    'PDF, PPT, DOC, ZIP · Max 50MB',
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
          label: widget.isEditing ? 'Save changes' : 'Upload attachments',
          onPressed: _canUpload ? _upload : null,
          enabled: _canUpload,
        ),
      ],
    );
  }
}

/// Converts sheet result into a list [AttachmentItem] for local UI state.
AttachmentItem attachmentFromResult(AddAttachmentResult result) {
  return AttachmentItem(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    title: result.title,
    fileName: result.fileName,
    sizeInBytes: 801500,
    uploadedAt: DateTime.now(),
  );
}
