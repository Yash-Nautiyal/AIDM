import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:aidm/core/widgets/button/app_circle_button.dart';
import 'package:aidm/core/widgets/datepicker/app_date_picker.dart';
import 'package:aidm/feature/calendar/presentation/pages/calendar_search_page.dart';
import 'package:aidm/feature/calendar/presentation/widgets/calendar_connect_banner.dart';
import 'package:aidm/feature/calendar/presentation/widgets/calendar_empty_state.dart';
import 'package:aidm/feature/webinar/domain/entities/webinar.dart';
import 'package:aidm/feature/webinar/presentation/pages/webinar_details_page.dart';
import 'package:aidm/feature/webinar/presentation/widgets/list/webinar_tile.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  bool _isConnected = false;
  bool _showConnectBanner = true;
  DateTime _selectedDate = DateTime(2026, 6, 18);

  static final _mockEvents = <Webinar>[
    Webinar(
      id: 'cal-1',
      title: 'Product Demo Day',
      teamAndLocation: 'Marketing team · India',
      startAt: DateTime(2026, 6, 18, 11, 0),
      endAt: DateTime(2026, 6, 18, 12, 30),
      timeZone: 'Asia/Calcutta',
      status: WebinarStatus.scheduled,
      inviteLink: 'webinar.gg/join/WBN-4829',
      code: 'HI-OS-PROD-DEMO',
      canStart: true,
    ),
    Webinar(
      id: 'cal-2',
      title: 'SEO Workshop',
      teamAndLocation: 'Marketing team · India',
      startAt: DateTime(2026, 6, 18, 15, 0),
      endAt: DateTime(2026, 6, 18, 17, 30),
      timeZone: 'Asia/Calcutta',
      status: WebinarStatus.scheduled,
      inviteLink: 'webinar.gg/join/WBN-4830',
      code: 'HI-OS-SEO-WORK',
    ),
    Webinar(
      id: 'cal-3',
      title: 'SEO Workshop',
      teamAndLocation: 'Marketing team · India',
      startAt: DateTime(2026, 6, 18, 15, 0),
      endAt: DateTime(2026, 6, 18, 17, 30),
      timeZone: 'Asia/Calcutta',
      status: WebinarStatus.scheduled,
      inviteLink: 'webinar.gg/join/WBN-4830',
      code: 'HI-OS-SEO-WORK',
    ),
    Webinar(
      id: 'cal-4',
      title: 'SEO Workshop',
      teamAndLocation: 'Marketing team · India',
      startAt: DateTime(2026, 6, 18, 15, 0),
      endAt: DateTime(2026, 6, 18, 17, 30),
      timeZone: 'Asia/Calcutta',
      status: WebinarStatus.scheduled,
      inviteLink: 'webinar.gg/join/WBN-4830',
      code: 'HI-OS-SEO-WORK',
    ),
    Webinar(
      id: 'cal-5',
      title: 'SEO Workshop',
      teamAndLocation: 'Marketing team · India',
      startAt: DateTime(2026, 6, 18, 15, 0),
      endAt: DateTime(2026, 6, 18, 17, 30),
      timeZone: 'Asia/Calcutta',
      status: WebinarStatus.scheduled,
      inviteLink: 'webinar.gg/join/WBN-4830',
      code: 'HI-OS-SEO-WORK',
    ),
    Webinar(
      id: 'cal-6',
      title: 'SEO Workshop',
      teamAndLocation: 'Marketing team · India',
      startAt: DateTime(2026, 6, 18, 15, 0),
      endAt: DateTime(2026, 6, 18, 17, 30),
      timeZone: 'Asia/Calcutta',
      status: WebinarStatus.scheduled,
      inviteLink: 'webinar.gg/join/WBN-4830',
      code: 'HI-OS-SEO-WORK',
    ),
  ];

  List<Webinar> get _eventsForSelectedDate {
    return _mockEvents
        .where(
          (event) =>
              event.startAt.year == _selectedDate.year &&
              event.startAt.month == _selectedDate.month &&
              event.startAt.day == _selectedDate.day,
        )
        .toList(growable: false);
  }

  void _connectCalendar() {
    setState(() {
      _isConnected = true;
      _showConnectBanner = false;
    });
  }

  void _upsertWebinar(Webinar webinar) {
    final index = _mockEvents.indexWhere((item) => item.id == webinar.id);
    if (index == -1) {
      _mockEvents.add(webinar);
    } else {
      _mockEvents[index] = webinar;
    }
  }

  void _deleteWebinar(String id) {
    _mockEvents.removeWhere((item) => item.id == id);
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

  void _openSearch() {
    moveTo(context, const CalendarSearchPage());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final events = _eventsForSelectedDate;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      extendBodyBehindAppBar: true,
      appBar: AppAppBar(
        title: 'Calendar',
        glassOpacity: .1,
        glassy: true,
        blurSigma: 10,
        actions: [
          AppCircleButton(onTap: _openSearch, iconPath: AppAssets.searchIcon),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: AppDimensions.pagePadding,
              sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_showConnectBanner && !_isConnected) ...[
                      CalendarConnectBanner(
                        onConnectTap: _connectCalendar,
                        onDismiss: () =>
                            setState(() => _showConnectBanner = false),
                      ),
                      SizedBox(height: AppDimensions.spacingVerticalLg),
                    ],
                    AppDatePicker(
                      initialDate: _selectedDate,
                      transparent: true,
                      showShadow: false,
                      onDateChanged: (date) =>
                          setState(() => _selectedDate = date),
                      onClear: () =>
                          setState(() => _selectedDate = DateTime.now()),
                      onDone: () {},
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(
                height: 1,
                thickness: 1,
                color: theme.borderDefault,
              ),
            ),
            if (!_isConnected)
              SliverPadding(
                padding: AppDimensions.pagePadding,
                sliver: SliverToBoxAdapter(
                  child: CalendarEmptyState(onConnectTap: _connectCalendar),
                ),
              )
            else if (events.isEmpty)
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.spacingVertical2xl,
                ),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'No webinars on this day.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: theme.textSecondary,
                      ),
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: AppDimensions.pagePadding,
                sliver: SliverList.separated(
                  itemCount: events.length,
                  separatorBuilder: (_, _) =>
                      SizedBox(height: AppDimensions.spacingVerticalMd),
                  itemBuilder: (context, index) {
                    final webinar = events[index];
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
