import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:aidm/core/widgets/button/app_circle_button.dart';
import 'package:aidm/feature/more/presenation/widgets/attachment/attachment_empty_state.dart';
import 'package:aidm/feature/more/presenation/widgets/attachment/attachment_list_item.dart';
import 'package:aidm/feature/more/presenation/widgets/attachment/show_add_attachment_sheet.dart';
import 'package:flutter/material.dart';

class AttachmentsPage extends StatefulWidget {
  const AttachmentsPage({super.key});

  @override
  State<AttachmentsPage> createState() => _AttachmentsPageState();
}

class _AttachmentsPageState extends State<AttachmentsPage> {
  final List<AttachmentItem> _attachments = [
    AttachmentItem(
      id: '1',
      title: 'Demo',
      fileName: 'Demo01.pdf',
      sizeInBytes: 801500,
      uploadedAt: DateTime(2026, 6, 30),
    ),
    AttachmentItem(
      id: '2',
      title: 'Files',
      fileName: 'album.pdf',
      sizeInBytes: 1200000,
      uploadedAt: DateTime(2026, 6, 30),
    ),
    AttachmentItem(
      id: '3',
      title: 'Presentation',
      fileName: 'slides.ppt',
      sizeInBytes: 2400000,
      uploadedAt: DateTime(2026, 6, 28),
    ),
    AttachmentItem(
      id: '4',
      title: 'Archive',
      fileName: 'assets.zip',
      sizeInBytes: 5600000,
      uploadedAt: DateTime(2026, 6, 25),
    ),
    AttachmentItem(
      id: '5',
      title: 'Brief',
      fileName: 'brief.docx',
      sizeInBytes: 340000,
      uploadedAt: DateTime(2026, 6, 22),
    ),
    AttachmentItem(
      id: '6',
      title: 'Cover',
      fileName: 'cover.png',
      sizeInBytes: 890000,
      uploadedAt: DateTime(2026, 6, 20),
    ),
  ];

  Future<void> _openAddSheet() async {
    final result = await showAddAttachmentSheet(context);
    if (!mounted || result == null) return;
    setState(() => _attachments.insert(0, attachmentFromResult(result)));
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _onOptionSelected(
    AttachmentItem item,
    AttachmentOption option,
  ) async {
    switch (option) {
      case AttachmentOption.download:
        _showMessage('Downloaded ${item.fileName}');
      case AttachmentOption.edit:
        await _editAttachment(item);
      case AttachmentOption.delete:
        _deleteAttachment(item);
    }
  }

  Future<void> _editAttachment(AttachmentItem item) async {
    final result = await showAddAttachmentSheet(
      context,
      initialTitle: item.title,
      initialFileName: item.fileName,
      isEditing: true,
    );
    if (!mounted || result == null) return;

    setState(() {
      final index = _attachments.indexWhere((a) => a.id == item.id);
      if (index == -1) return;
      _attachments[index] = item.copyWith(
        title: result.title,
        fileName: result.fileName,
      );
    });
    _showMessage('Updated ${result.title}');
  }

  void _deleteAttachment(AttachmentItem item) {
    setState(() => _attachments.removeWhere((a) => a.id == item.id));
    _showMessage('Deleted ${item.title}');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final count = _attachments.length;
    final countLabel = '$count Attachment${count == 1 ? '' : 's'}';

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'Attachments', showBack: true),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimensions.pagePadding,
                AppDimensions.spacingVerticalLg,
                AppDimensions.pagePadding,
                AppDimensions.spacingVerticalMd,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      countLabel,
                      style: typography.bodyMedium.copyWith(
                        color: theme.textSecondary,
                      ),
                    ),
                  ),
                  if (count > 0) AppCircleButton(onTap: _openAddSheet),
                ],
              ),
            ),
            Expanded(
              child: count == 0
                  ? AttachmentEmptyState(onUpload: _openAddSheet)
                  : ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        AppDimensions.pagePadding,
                        0,
                        AppDimensions.pagePadding,
                        AppDimensions.spacingVertical3xl,
                      ),
                      itemCount: count,
                      separatorBuilder: (_, _) =>
                          SizedBox(height: AppDimensions.spacingVerticalMd),
                      itemBuilder: (context, index) {
                        final item = _attachments[index];
                        return AttachmentListItem(
                          item: item,
                          onOptionSelected: (option) =>
                              _onOptionSelected(item, option),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
