import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/widgets/pill/app_pill.dart';
import 'package:aidm/feature/webinar/domain/entities/webinar.dart';
import 'package:flutter/material.dart';

class WebinarTabRow extends StatelessWidget {
  const WebinarTabRow({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  final WebinarTab selectedTab;
  final ValueChanged<WebinarTab> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppPill(
          label: 'Upcoming',
          isSelected: selectedTab == WebinarTab.upcoming,
          onTap: () => onTabChanged(WebinarTab.upcoming),
        ),
        SizedBox(width: AppDimensions.spacingSm),
        AppPill(
          label: 'Past',
          isSelected: selectedTab == WebinarTab.past,
          onTap: () => onTabChanged(WebinarTab.past),
        ),
      ],
    );
  }
}
