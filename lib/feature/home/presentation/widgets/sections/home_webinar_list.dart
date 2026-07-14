import 'package:aidm/core/constant/app_animations.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/common/date_time_utils.dart';
import '../webinar_list/home_webinar_cards.dart';
import '../webinar_list/home_webinar_date_filter.dart';
import '../webinar_list/home_webinar_list_empty.dart';

class HomeWebinarList extends StatefulWidget {
  const HomeWebinarList({
    super.key,
    required this.title,
    required this.subtitle,
    this.onCalendarTap,
    this.onPrevDayTap,
    this.onNextDayTap,
    this.webinars = const [],
    this.initialDate,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onCalendarTap;
  final VoidCallback? onPrevDayTap;
  final VoidCallback? onNextDayTap;
  final List<HomeWebinarCardData> webinars;
  final DateTime? initialDate;

  @override
  State<HomeWebinarList> createState() => _HomeWebinarListState();
}

class _HomeWebinarListState extends State<HomeWebinarList> {
  late DateTime _selectedDate;
  int _slideDirection = 1;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTimeUtils.dateOnly(
      widget.initialDate ?? DateTime.now(),
    );
  }

  void _goToPreviousDay() {
    setState(() {
      _slideDirection = -1;
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
    widget.onPrevDayTap?.call();
  }

  void _goToNextDay() {
    setState(() {
      _slideDirection = 1;
      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
    widget.onNextDayTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final visibleWebinars = widget.webinars
        .where((w) => DateTimeUtils.dateOnly(w.date) == _selectedDate)
        .toList(growable: false);
    final hasWebinars = visibleWebinars.isNotEmpty;

    final dateLabel = DateTimeUtils.formatDateLabel(_selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeWebinarDateFilter(
          label: dateLabel,
          onCalendarTap: widget.onCalendarTap,
          onPrevTap: _goToPreviousDay,
          onNextTap: _goToNextDay,
        ),
        SizedBox(height: AppDimensions.spacingVerticalMd),
        AppAnimations.contentSwitcher(
          switchKey:
              '${_selectedDate.toIso8601String()}-$hasWebinars-${visibleWebinars.length}',
          direction: _slideDirection,
          child: hasWebinars
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: visibleWebinars.length,
                  itemBuilder: (context, index) {
                    return HomeWebinarCard(data: visibleWebinars[index]);
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: AppDimensions.spacingVerticalMd),
                )
              : HomeWebinarListEmpty(
                  title: widget.title,
                  subtitle: widget.subtitle,
                  theme: theme,
                  typography: typography,
                ),
        ),
      ],
    );
  }
}
