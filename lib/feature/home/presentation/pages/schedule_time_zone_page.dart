import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_app_bar.dart';
import 'package:aidm/core/widgets/input/app_input1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScheduleTimeZonePage extends StatefulWidget {
  const ScheduleTimeZonePage({super.key, required this.initialValue});

  final String initialValue;

  @override
  State<ScheduleTimeZonePage> createState() => _ScheduleTimeZonePageState();
}

class _TimeZoneItem {
  const _TimeZoneItem({
    required this.offset,
    required this.label,
    required this.value,
  });

  final String offset;
  final String label;
  final String value;
}

class _ScheduleTimeZonePageState extends State<ScheduleTimeZonePage> {
  final _searchController = TextEditingController();

  late String _selectedValue;

  final _items = const <_TimeZoneItem>[
    _TimeZoneItem(
      offset: '(GMT+5:30)',
      label: 'Mumbai, Kolkata, Chennai',
      value: 'Asia/Calcutta',
    ),
    _TimeZoneItem(
      offset: '(GMT+5:30)',
      label: 'New Delhi',
      value: 'Asia/New_Delhi',
    ),
    _TimeZoneItem(
      offset: '(GMT+5:45)',
      label: 'Kathmandu',
      value: 'Asia/Kathmandu',
    ),
    _TimeZoneItem(
      offset: '(GMT+6:00)',
      label: 'Dhaka, Astana',
      value: 'Asia/Dhaka',
    ),
    _TimeZoneItem(
      offset: '(GMT+7:00)',
      label: 'Bangkok, Hanoi, Jakarta',
      value: 'Asia/Bangkok',
    ),
    _TimeZoneItem(
      offset: '(GMT+8:00)',
      label: 'Beijing, Singapore',
      value: 'Asia/Singapore',
    ),
    _TimeZoneItem(
      offset: '(GMT+9:00)',
      label: 'Tokyo, Seoul',
      value: 'Asia/Tokyo',
    ),
    _TimeZoneItem(
      offset: '(GMT+9:30)',
      label: 'Adelaide',
      value: 'Australia/Adelaide',
    ),
    _TimeZoneItem(
      offset: '(GMT+10:00)',
      label: 'Sydney, Melbourne',
      value: 'Australia/Sydney',
    ),
    _TimeZoneItem(
      offset: '(GMT+0:00)',
      label: 'London (GMT)',
      value: 'Europe/London',
    ),
    _TimeZoneItem(
      offset: '(GMT-5:00)',
      label: 'Eastern Time (US & Canada)',
      value: 'America/New_York',
    ),
    _TimeZoneItem(
      offset: '(GMT-6:00)',
      label: 'Central Time (US & Canada)',
      value: 'America/Chicago',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    final query = _searchController.text.trim().toLowerCase();
    final filtered = query.isEmpty
        ? _items
        : _items
              .where(
                (e) =>
                    e.label.toLowerCase().contains(query) ||
                    e.value.toLowerCase().contains(query) ||
                    e.offset.toLowerCase().contains(query),
              )
              .toList(growable: false);

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'Time Zone', showBack: true),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.pagePadding,
              ),
              child: AppInput(
                controller: _searchController,
                prefixIcon: Transform.scale(
                  scale: 0.35,
                  child: SvgPicture.asset(AppAssets.searchIcon),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            SizedBox(height: AppDimensions.spacingVerticalLg),
            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.pagePadding,
                ),
                itemBuilder: (context, index) {
                  final item = filtered[index];
                  final isSelected = item.value == _selectedValue;
                  final labelColor = isSelected
                      ? theme.brandPrimary
                      : theme.textPrimary;
                  return InkWell(
                    onTap: () {
                      setState(() => _selectedValue = item.value);
                      Navigator.of(context).pop(item.value);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.spacingVerticalLg,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100.sp,
                            child: Text(
                              item.offset,
                              style: typography.bodyMedium.copyWith(
                                color: isSelected
                                    ? labelColor
                                    : theme.textSecondary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item.label,
                              style: typography.bodyMedium.copyWith(
                                color: labelColor,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_rounded,
                              color: theme.brandPrimary,
                              size: 25.sp,
                            ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) =>
                    SizedBox(height: AppDimensions.spacingVerticalXs),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
