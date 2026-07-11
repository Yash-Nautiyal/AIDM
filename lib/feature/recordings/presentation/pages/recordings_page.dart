import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:aidm/feature/recordings/domain/entities/recording.dart';
import 'package:aidm/feature/recordings/presentation/pages/recording_player_page.dart';
import 'package:aidm/feature/recordings/presentation/widgets/recordings/list/recording_filter_row.dart';
import 'package:aidm/feature/recordings/presentation/widgets/recordings/list/recording_tile.dart';
import 'package:aidm/feature/recordings/presentation/widgets/sheets/recording_upload_sheet.dart';
import 'package:flutter/material.dart';

class RecordingsPage extends StatefulWidget {
  const RecordingsPage({super.key});

  @override
  State<RecordingsPage> createState() => _RecordingsPageState();
}

class _RecordingsPageState extends State<RecordingsPage> {
  RecordingFilter _selectedFilter = RecordingFilter.all;

  static final _allRecordings = <Recording>[
    Recording(
      id: '1',
      title: 'Product Demo Day',
      teamAndLocation: 'Marketing team · India',
      attendedCount: 47,
      date: DateTime(2026, 6, 17),
      duration: Duration(hours: 1, minutes: 30),
      isPreRecorded: false,
      chapters: [
        RecordingChapter(
          title: 'Introduction & welcome',
          startTime: Duration.zero,
        ),
        RecordingChapter(
          title: 'Product walkthrough',
          startTime: Duration(minutes: 5, seconds: 3),
        ),
        RecordingChapter(
          title: 'Live demo',
          startTime: Duration(minutes: 34, seconds: 3),
        ),
        RecordingChapter(
          title: 'Wrap up & next steps',
          startTime: Duration(minutes: 55),
        ),
      ],
    ),
    Recording(
      id: '2',
      title: 'Product Demo Day',
      teamAndLocation: 'Marketing team · India',
      attendedCount: 47,
      date: DateTime(2026, 6, 17),
      duration: Duration(hours: 1, minutes: 30),
      isPreRecorded: true,
      chapters: [
        RecordingChapter(
          title: 'Introduction & welcome',
          startTime: Duration.zero,
        ),
        RecordingChapter(
          title: 'Product walkthrough',
          startTime: Duration(minutes: 5, seconds: 3),
        ),
      ],
    ),
    Recording(
      id: '3',
      title: 'Product Demo Day',
      teamAndLocation: 'Marketing team · India',
      attendedCount: 47,
      date: DateTime(2026, 6, 17),
      duration: Duration(hours: 1, minutes: 30),
      isPreRecorded: false,
      chapters: [
        RecordingChapter(
          title: 'Introduction & welcome',
          startTime: Duration.zero,
        ),
      ],
    ),
    Recording(
      id: '4',
      title: 'Product Demo Day',
      teamAndLocation: 'Marketing team · India',
      attendedCount: 47,
      date: DateTime(2026, 6, 17),
      duration: Duration(hours: 1, minutes: 30),
      isPreRecorded: true,
      chapters: [
        RecordingChapter(
          title: 'Introduction & welcome',
          startTime: Duration.zero,
        ),
      ],
    ),
  ];

  List<Recording> get _filteredRecordings {
    return switch (_selectedFilter) {
      RecordingFilter.all => _allRecordings,
      RecordingFilter.preRecorded =>
        _allRecordings.where((r) => r.isPreRecorded).toList(),
    };
  }

  void _openPlayer(Recording recording) {
    moveTo(context, RecordingPlayerPage(recording: recording));
  }

  void _onOptionSelected(Recording recording, RecordingOption option) {
    // TODO: Handle option actions when wired to backend.
  }

  Future<void> _openUploadSheet() async {
    final title = await showRecordingUploadSheet(context);
    if (!mounted || title == null) return;
    // Handle upload when wired to backend. TODO: Implement upload.
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final recordings = _filteredRecordings;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'Recordings'),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimensions.pagePadding,
                AppDimensions.spacingVerticalLg,
                AppDimensions.pagePadding,
                AppDimensions.spacingVerticalMd,
              ),
              child: RecordingFilterRow(
                selectedFilter: _selectedFilter,
                onFilterChanged: (filter) {
                  setState(() => _selectedFilter = filter);
                },
                onAddTap: _openUploadSheet,
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.pagePadding,
                  0,
                  AppDimensions.pagePadding,
                  AppDimensions.spacingVertical3xl,
                ),
                itemCount: recordings.length,
                separatorBuilder: (_, _) => Divider(
                  height: 1,
                  thickness: 1,
                  color: theme.borderDefault,
                ),
                itemBuilder: (context, index) {
                  final recording = recordings[index];
                  return RecordingTile(
                    recording: recording,
                    onTap: () => _openPlayer(recording),
                    onOptionSelected: (option) =>
                        _onOptionSelected(recording, option),
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
