import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/dialog/ios_action_sheet.dart';
import 'package:aidm/feature/webinar/domain/entities/webinar.dart';
import 'package:aidm/feature/webinar/presentation/widgets/details/webinar_attachments_section.dart';
import 'package:aidm/feature/webinar/presentation/widgets/details/webinar_settings_section.dart';
import 'package:aidm/feature/webinar/presentation/widgets/details/webinar_summary_card.dart';
import 'package:aidm/feature/webinar/presentation/widgets/sheets/webinar_title_edit_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/attachments.dart';

class WebinarEditPage extends StatefulWidget {
  const WebinarEditPage({super.key, required this.webinar});

  final Webinar webinar;

  @override
  State<WebinarEditPage> createState() => _WebinarEditPageState();
}

class _WebinarEditPageState extends State<WebinarEditPage> {
  late Webinar _draft;
  late bool _waitingRoom;
  late bool _watermark;
  late List<WebinarAttachment> _attachments;
  final _picker = ImagePicker();
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _draft = widget.webinar;
    _waitingRoom = widget.webinar.waitingRoom;
    _watermark = widget.webinar.watermark;
    _attachments = List<WebinarAttachment>.from(widget.webinar.attachments);
  }

  Future<void> _editTitle() async {
    final title = await showWebinarTitleEditSheet(
      context,
      initialTitle: _draft.title,
    );
    if (!mounted || title == null) return;
    setState(() => _draft = _draft.copyWith(title: title));
  }

  Future<void> _uploadAttachment() async {
    if (_isUploading) return;
    setState(() => _isUploading = true);
    try {
      final file = await _picker.pickMedia();
      if (!mounted || file == null) return;

      setState(() {
        _attachments = [
          ..._attachments,
          WebinarAttachment(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            name: file.name,
          ),
        ];
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${file.name} uploaded')));
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _removeAttachment(WebinarAttachment attachment) {
    setState(() {
      _attachments = _attachments
          .where((item) => item.id != attachment.id)
          .toList(growable: false);
    });
  }

  void _save() {
    final updated = _draft.copyWith(
      waitingRoom: _waitingRoom,
      watermark: _watermark,
      attachments: _attachments,
    );
    moveBack(context, WebinarEditSaved(updated));
  }

  Future<void> _confirmDelete() async {
    await showIosActionSheet(
      context,
      options: [
        IosActionSheetOption(
          label: 'Delete Webinar',
          onPressed: () {
            moveBack(context, WebinarEditDeleted(_draft.id));
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'Webinar Details', showBack: true),
      body: SafeArea(
        child: Column(
          children: [
            Divider(height: 1, thickness: 1, color: theme.borderDefault),
            Expanded(
              child: SingleChildScrollView(
                padding: AppDimensions.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    WebinarSummaryCard(
                      webinar: _draft,
                      showWebinarId: true,
                      onEdit: _editTitle,
                    ),
                    SizedBox(height: AppDimensions.spacingVerticalLg),
                    WebinarSettingsSection(
                      waitingRoom: _waitingRoom,
                      watermark: _watermark,
                      onWaitingRoomChanged: (value) {
                        setState(() => _waitingRoom = value);
                      },
                      onWatermarkChanged: (value) {
                        setState(() => _watermark = value);
                      },
                    ),
                    SizedBox(height: AppDimensions.spacingVerticalLg),
                    WebinarAttachmentsSection(
                      attachments: _attachments,
                      onUpload: _isUploading ? () {} : _uploadAttachment,
                      onRemove: _removeAttachment,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: AppDimensions.pagePadding,
              child: Column(
                children: [
                  AppButton(label: 'Save', onPressed: _save),
                  SizedBox(height: AppDimensions.spacingVerticalMd),
                  AppButton(
                    label: 'Delete',
                    onPressed: _confirmDelete,
                    type: AppButton1Type.secondary,
                    delete: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
