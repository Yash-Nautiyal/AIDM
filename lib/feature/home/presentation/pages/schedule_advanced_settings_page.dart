import 'package:aidm/core/constant/app_animations.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_app_bar.dart';
import 'package:aidm/core/widgets/toggle/app_toggle.dart';
import 'package:aidm/feature/home/presentation/widgets/schedule/advanced_settings/fields/advanced_passcode_fields.dart';
import 'package:aidm/feature/home/presentation/widgets/schedule/advanced_settings/fields/advanced_prerecorded_fields.dart';
import 'package:aidm/feature/home/presentation/widgets/schedule/advanced_settings/fields/advanced_recording_fields.dart';
import 'package:aidm/feature/home/presentation/widgets/schedule/advanced_settings/fields/advanced_repeat_fields.dart';
import 'package:aidm/feature/home/presentation/widgets/schedule/advanced_settings/prerecorded/prerecorded_video_source_segment.dart';
import 'package:aidm/feature/home/presentation/widgets/schedule/advanced_settings/prerecorded/show_prerecorded_recordings_sheet.dart';
import 'package:flutter/material.dart';

class ScheduleAdvancedSettingsPage extends StatefulWidget {
  const ScheduleAdvancedSettingsPage({super.key});

  @override
  State<ScheduleAdvancedSettingsPage> createState() =>
      _ScheduleAdvancedSettingsPageState();
}

class _AdvancedSetting {
  const _AdvancedSetting({
    required this.title,
    required this.subtitle,
    required this.keyName,
  });

  final String title;
  final String subtitle;
  final String keyName;
}

class _ScheduleAdvancedSettingsPageState
    extends State<ScheduleAdvancedSettingsPage> {
  final _passcodeController = TextEditingController();

  final _settings = const <_AdvancedSetting>[
    _AdvancedSetting(
      keyName: 'repeat',
      title: 'Repeat',
      subtitle: 'Schedule this webinar to repeat at regular\nintervals',
    ),
    _AdvancedSetting(
      keyName: 'private_webinar',
      title: 'Private Webinar',
      subtitle:
          'Make this webinar private. Require Login\nwill be enabled automatically.',
    ),
    _AdvancedSetting(
      keyName: 'watermark',
      title: 'Enable Watermark',
      subtitle:
          'Show viewer ID and email (or name for\nguests) as a watermark on the video',
    ),
    _AdvancedSetting(
      keyName: 'live_users_count',
      title: 'Show Live Users Count',
      subtitle: 'Show the live users count to users',
    ),
    _AdvancedSetting(
      keyName: 'waiting_room',
      title: 'Waiting Room',
      subtitle:
          'Attendees must be approved by the host\nbefore they can join the webinar',
    ),
    _AdvancedSetting(
      keyName: 'recording',
      title: 'Enable Recording',
      subtitle: 'Record the webinar for playback later',
    ),
    _AdvancedSetting(
      keyName: 'prerecorded',
      title: 'Pre-recorded Webinar',
      subtitle:
          'Host webinar using a pre-recorded video.\nSelect an existing recording or upload a\nnew MP4 below.',
    ),
    _AdvancedSetting(
      keyName: 'require_login',
      title: 'Require Login',
      subtitle: 'Require attendees to login to join the\nwebinar',
    ),
    _AdvancedSetting(
      keyName: 'require_passcode',
      title: 'Require Passcode',
      subtitle: 'Protect your webinar with a passcode',
    ),
  ];

  late final Map<String, bool> _values = {
    for (final s in _settings) s.keyName: false,
  };

  String _repeatFrequency = 'Daily';
  int _repeatInterval = 1;
  String _repeatEnds = 'After N times';
  int _repeatOccurrences = 2;
  String _recordingVisibility = ScheduleAdvancedRecordingFields.visibilityOptions.first;
  PrerecordedVideoSource _prerecordedVideoSource = PrerecordedVideoSource.recordings;
  PrerecordedRecordingItem? _selectedPrerecordedRecording;
  String? _uploadedPrerecordedFileName;

  static const _prerecordedRecordings = [
    PrerecordedRecordingItem(
      id: '1',
      title: 'Product Demo Day',
      meta: 'Jun 11, 2026 · 1:41:22',
    ),
    PrerecordedRecordingItem(
      id: '2',
      title: 'Weekly Team Sync',
      meta: 'May 28, 2026 · 0:58:10',
    ),
    PrerecordedRecordingItem(
      id: '3',
      title: 'Customer Onboarding',
      meta: 'May 15, 2026 · 1:12:45',
    ),
  ];

  void _setValue(String key, bool value) {
    setState(() => _values[key] = value);
  }

  @override
  void dispose() {
    _passcodeController.dispose();
    super.dispose();
  }

  Widget _buildSettingRow(_AdvancedSetting setting) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final value = _values[setting.keyName] ?? false;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingLg,
        vertical: AppDimensions.spacingVerticalLg,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(setting.title, style: typography.bodyMedium),
                SizedBox(height: AppDimensions.spacingVerticalXs),
                Text(
                  setting.subtitle,
                  style: typography.captionLight.copyWith(
                    color: theme.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          AppToggle(
            value: value,
            onChanged: (v) => _setValue(setting.keyName, v),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final isRepeatEnabled = _values['repeat'] ?? false;
    final isRecordingEnabled = _values['recording'] ?? false;
    final isPrerecordedEnabled = _values['prerecorded'] ?? false;
    final isPasscodeEnabled = _values['require_passcode'] ?? false;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'Advance Settings', showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppDimensions.pagePadding),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: theme.borderDefault),
              borderRadius: BorderRadius.circular(AppDimensions.spacing2xl),
            ),
            child: Column(
              children: List.generate(_settings.length, (index) {
                final setting = _settings[index];
                return Column(
                  children: [
                    _buildSettingRow(setting),
                    if (setting.keyName == 'repeat')
                      AppAnimations.expandCollapse(
                        isExpanded: isRepeatEnabled,
                        child: ScheduleAdvancedRepeatFields(
                          frequency: _repeatFrequency,
                          interval: _repeatInterval,
                          ends: _repeatEnds,
                          occurrences: _repeatOccurrences,
                          onFrequencyChanged: (v) =>
                              setState(() => _repeatFrequency = v),
                          onIntervalChanged: (v) =>
                              setState(() => _repeatInterval = v),
                          onEndsChanged: (v) => setState(() => _repeatEnds = v),
                          onOccurrencesChanged: (v) =>
                              setState(() => _repeatOccurrences = v),
                        ),
                      ),
                    if (setting.keyName == 'recording')
                      AppAnimations.expandCollapse(
                        isExpanded: isRecordingEnabled,
                        child: ScheduleAdvancedRecordingFields(
                          visibility: _recordingVisibility,
                          onVisibilityChanged: (v) =>
                              setState(() => _recordingVisibility = v),
                        ),
                      ),
                    if (setting.keyName == 'prerecorded')
                      AppAnimations.expandCollapse(
                        isExpanded: isPrerecordedEnabled,
                        child: ScheduleAdvancedPrerecordedFields(
                          videoSource: _prerecordedVideoSource,
                          selectedRecording: _selectedPrerecordedRecording,
                          uploadedFileName: _uploadedPrerecordedFileName,
                          recordings: _prerecordedRecordings,
                          onVideoSourceChanged: (v) =>
                              setState(() => _prerecordedVideoSource = v),
                          onRecordingSelected: (v) => setState(
                            () => _selectedPrerecordedRecording = v,
                          ),
                          onFileUploaded: (v) => setState(
                            () => _uploadedPrerecordedFileName = v,
                          ),
                        ),
                      ),
                    if (setting.keyName == 'require_passcode')
                      AppAnimations.expandCollapse(
                        isExpanded: isPasscodeEnabled,
                        child: ScheduleAdvancedPasscodeFields(
                          controller: _passcodeController,
                        ),
                      ),
                    if (index != _settings.length - 1)
                      Divider(color: theme.borderDefault, height: 1),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
