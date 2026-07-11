import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/feature/calendar/presentation/pages/calendar_page.dart';
import 'package:aidm/feature/home/presentation/pages/home_page.dart';
import 'package:aidm/feature/more/presenation/pages/more_page.dart';
import 'package:aidm/feature/recordings/presentation/pages/recordings_page.dart';
import 'package:aidm/feature/webinar/presentation/pages/webinar_page.dart';
import 'package:flutter/material.dart';

abstract final class ShellRoutes {
  static const List<Widget> tabs = [
    ShellTab(child: HomePage()),
    ShellTab(child: WebinarPage()),
    ShellTab(child: CalendarPage()),
    ShellTab(child: RecordingsPage()),
    ShellTab(child: MorePage()),
  ];
}
