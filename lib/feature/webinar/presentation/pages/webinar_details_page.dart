import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/utils/share_utils.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/feature/home/presentation/widgets/sheets/start/start_webinar_sheet.dart';
import 'package:aidm/feature/webinar/domain/entities/webinar.dart';
import 'package:aidm/feature/webinar/presentation/pages/webinar_edit_page.dart';
import 'package:aidm/feature/webinar/presentation/widgets/details/webinar_invite_section.dart';
import 'package:aidm/feature/webinar/presentation/widgets/details/webinar_summary_card.dart';
import 'package:flutter/material.dart';

class WebinarDetailsPage extends StatefulWidget {
  const WebinarDetailsPage({super.key, required this.webinar});

  final Webinar webinar;

  @override
  State<WebinarDetailsPage> createState() => _WebinarDetailsPageState();
}

class _WebinarDetailsPageState extends State<WebinarDetailsPage> {
  late Webinar _webinar;
  final _shareButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _webinar = widget.webinar;
  }

  Future<void> _openEdit() async {
    final result = await moveTo<WebinarEditResult>(
      context,
      WebinarEditPage(webinar: _webinar),
    );
    if (!mounted || result == null) return;

    switch (result) {
      case WebinarEditSaved(:final webinar):
        setState(() => _webinar = webinar);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Webinar saved')));
      case WebinarEditDeleted():
        moveBack(context, result);
    }
  }

  Future<void> _startWebinar() async {
    await showStartWebinarSheet(context);
  }

  Future<void> _share() async {
    await ShareUtils.shareWebinarInvite(
      context: context,
      title: _webinar.title,
      inviteLink: _webinar.inviteLink,
      sharePositionOrigin: ShareUtils.originFromContext(
        _shareButtonKey.currentContext ?? context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        moveBack(context, WebinarEditSaved(_webinar));
      },
      child: Scaffold(
        backgroundColor: theme.backgroundPage,
        appBar: AppAppBar(
          title: 'Webinar Details',
          showBack: true,
          onBack: () => moveBack(context, WebinarEditSaved(_webinar)),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Divider(height: 1, thickness: 1, color: theme.borderDefault),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    AppDimensions.pagePadding,
                    AppDimensions.spacingVerticalLg,
                    AppDimensions.pagePadding,
                    AppDimensions.spacingVerticalLg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      WebinarSummaryCard(webinar: _webinar, onEdit: _openEdit),
                      SizedBox(height: AppDimensions.spacingVerticalLg),
                      WebinarInviteSection(
                        inviteLink: _webinar.inviteLink,
                        code: _webinar.code,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.pagePadding,
                  AppDimensions.spacingVerticalSm,
                  AppDimensions.pagePadding,
                  AppDimensions.spacingVerticalLg,
                ),
                child: Column(
                  children: [
                    AppButton(label: 'Start Webinar', onPressed: _startWebinar),
                    SizedBox(height: AppDimensions.spacingVerticalMd),
                    AppButton(
                      key: _shareButtonKey,
                      label: 'Share',
                      type: AppButton1Type.secondary,
                      onPressed: _share,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
