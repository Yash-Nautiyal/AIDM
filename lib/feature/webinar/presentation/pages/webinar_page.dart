import 'package:aidm/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/app_dimensions.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/widgets/app_bar/app_appbar.dart';
import '../../../../core/widgets/button/app_floating_button.dart';
import '../../../home/presentation/pages/schedule_page.dart';
import '../../domain/entities/webinar.dart';
import '../widgets/list/webinar_list_empty.dart';
import '../widgets/list/webinar_tab_row.dart';
import '../widgets/list/webinar_tile.dart';
import 'webinar_details_page.dart';

class WebinarPage extends StatefulWidget {
  const WebinarPage({super.key});

  @override
  State<WebinarPage> createState() => _WebinarPageState();
}

class _WebinarPageState extends State<WebinarPage> {
  WebinarTab _selectedTab = WebinarTab.upcoming;

  static final _now = DateTime.now();

  final _allWebinars = <Webinar>[
    Webinar(
      id: '1',
      title: 'Product Demo Day',
      teamAndLocation: 'Marketing team · India',
      startAt: DateTime(_now.year, _now.month, _now.day, 11, 0),
      endAt: DateTime(_now.year, _now.month, _now.day, 12, 30),
      timeZone: 'Asia/Calcutta',
      status: WebinarStatus.scheduled,
      inviteLink: 'webinar.gg/join/WBN-4829',
      code: 'HI-OS-PROD-DEMO',
      canStart: true,
    ),
    Webinar(
      id: '2',
      title: 'SEO Workshop',
      teamAndLocation: 'Marketing team · India',
      startAt: DateTime(_now.year, _now.month, _now.day, 15, 0),
      endAt: DateTime(_now.year, _now.month, _now.day, 17, 30),
      timeZone: 'Asia/Calcutta',
      status: WebinarStatus.scheduled,
      inviteLink: 'webinar.gg/join/WBN-4830',
      code: 'HI-OS-SEO-WORK',
    ),
    Webinar(
      id: '3',
      title: 'Demo Webinar',
      teamAndLocation: 'Product team · India',
      startAt: DateTime(2026, 6, 19, 15, 45),
      endAt: DateTime(2026, 6, 19, 16, 45),
      timeZone: 'Asia/Calcutta',
      status: WebinarStatus.past,
      inviteLink: 'webinar.gg/join/WBN-4829',
      code: 'HI-OS-PROD-DEMO',
      isPast: true,
    ),
  ];

  List<Webinar> get _filteredWebinars {
    return switch (_selectedTab) {
      WebinarTab.upcoming =>
        _allWebinars.where((w) => !w.isPast).toList(growable: false),
      WebinarTab.past =>
        _allWebinars.where((w) => w.isPast).toList(growable: false),
    };
  }

  void _upsertWebinar(Webinar webinar) {
    final index = _allWebinars.indexWhere((item) => item.id == webinar.id);
    if (index == -1) {
      _allWebinars.add(webinar);
    } else {
      _allWebinars[index] = webinar;
    }
  }

  void _deleteWebinar(String id) {
    _allWebinars.removeWhere((item) => item.id == id);
  }

  Future<void> _openDetails(Webinar webinar) async {
    final result = await moveTo<WebinarEditResult>(
      context,
      WebinarDetailsPage(webinar: webinar),
    );
    if (!mounted || result == null) return;

    setState(() {
      switch (result) {
        case WebinarEditSaved(:final webinar):
          _upsertWebinar(webinar);
        case WebinarEditDeleted(:final id):
          _deleteWebinar(id);
      }
    });

    if (result is WebinarEditDeleted && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Webinar deleted')));
    }
  }

  void _openSchedule() {
    moveTo(context, const SchedulePage());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final webinars = _filteredWebinars;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'Webinars'),
      floatingActionButton: AppFloatingButton(onPressed: _openSchedule),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: AppDimensions.pagePadding,
              child: WebinarTabRow(
                selectedTab: _selectedTab,
                onTabChanged: (tab) => setState(() => _selectedTab = tab),
              ),
            ),
            Expanded(
              child: webinars.isEmpty
                  ? WebinarListEmpty(onSchedule: _openSchedule)
                  : ListView.separated(
                      padding: AppDimensions.pagePadding.copyWith(top: 0),
                      itemCount: webinars.length,
                      separatorBuilder: (_, _) =>
                          SizedBox(height: AppDimensions.spacingVerticalMd),
                      itemBuilder: (context, index) {
                        final webinar = webinars[index];
                        return WebinarTile(
                          webinar: webinar,
                          onTap: () => _openDetails(webinar),
                          onActionTap: () => _openDetails(webinar),
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
