import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/feature/calendar/presentation/models/calendar_filters.dart';
import 'package:aidm/feature/calendar/presentation/widgets/calendar_filter_chip.dart';
import 'package:aidm/feature/calendar/presentation/widgets/calendar_filter_sheet.dart';
import 'package:aidm/feature/calendar/presentation/widgets/calendar_search_bar.dart';
import 'package:flutter/material.dart';

class CalendarSearchPage extends StatefulWidget {
  const CalendarSearchPage({super.key});

  @override
  State<CalendarSearchPage> createState() => _CalendarSearchPageState();
}

class _CalendarSearchPageState extends State<CalendarSearchPage> {
  final _searchController = TextEditingController();

  CalendarDateFilter _dateFilter = CalendarDateFilter.anyTime;
  CalendarTypeFilter _typeFilter = CalendarTypeFilter.any;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openDateFilter() async {
    final result = await showCalendarFilterSheet<CalendarDateFilter>(
      context: context,
      title: 'Date',
      options: CalendarDateFilter.values,
      selected: _dateFilter,
      labelBuilder: (option) => option.label,
    );
    if (!mounted || result == null) return;
    setState(() => _dateFilter = result);
  }

  Future<void> _openTypeFilter() async {
    final result = await showCalendarFilterSheet<CalendarTypeFilter>(
      context: context,
      title: 'Type',
      options: CalendarTypeFilter.values,
      selected: _typeFilter,
      labelBuilder: (option) => option.label,
    );
    if (!mounted || result == null) return;
    setState(() => _typeFilter = result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CalendarSearchBar(
              controller: _searchController,
              onCancel: () => maybeMoveBack(context),
            ),
            Divider(height: 1, thickness: 1, color: theme.borderDefault),
            Padding(
              padding: AppDimensions.pagePadding.copyWith(bottom: 0),
              child: Row(
                children: [
                  CalendarFilterChip(
                    label: _dateFilter.chipLabel,
                    isActive: true,
                    onTap: _openDateFilter,
                  ),
                  SizedBox(width: AppDimensions.spacingSm),
                  CalendarFilterChip(
                    label: _typeFilter == CalendarTypeFilter.any
                        ? 'Type'
                        : _typeFilter.chipLabel,
                    isActive: _typeFilter != CalendarTypeFilter.any,
                    onTap: _openTypeFilter,
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
