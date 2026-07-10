import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/widgets/toggle/app_toggle.dart';
import 'package:aidm/feature/home/presentation/widgets/sheets/start/start_sheet_setting_row.dart';
import 'package:flutter/material.dart';

class WebinarSettingsSection extends StatelessWidget {
  const WebinarSettingsSection({
    super.key,
    required this.waitingRoom,
    required this.watermark,
    required this.onWaitingRoomChanged,
    required this.onWatermarkChanged,
  });

  final bool waitingRoom;
  final bool watermark;
  final ValueChanged<bool> onWaitingRoomChanged;
  final ValueChanged<bool> onWatermarkChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        border: Border.all(color: theme.borderDefault),
      ),
      child: Column(
        children: [
          StartSheetSettingsRow(
            title: 'Waiting Room',
            subtitle: 'Approve attendees before joining',
            trailing: AppToggle(
              value: waitingRoom,
              onChanged: onWaitingRoomChanged,
            ),
          ),
          Divider(height: 1, thickness: 1, color: theme.borderDefault),
          StartSheetSettingsRow(
            title: 'Watermark',
            subtitle: 'Show viewer ID on video',
            trailing: AppToggle(
              value: watermark,
              onChanged: onWatermarkChanged,
            ),
          ),
        ],
      ),
    );
  }
}
