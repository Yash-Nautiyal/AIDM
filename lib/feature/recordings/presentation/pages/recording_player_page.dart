import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/feature/recordings/domain/entities/recording.dart';
import 'package:aidm/feature/recordings/presentation/widgets/recordings/player/recording_info_section.dart';
import 'package:aidm/feature/recordings/presentation/widgets/recordings/player/recording_overview_section.dart';
import 'package:aidm/feature/recordings/presentation/widgets/recordings/player/recording_player_view.dart';
import 'package:flutter/material.dart';

class RecordingPlayerPage extends StatefulWidget {
  const RecordingPlayerPage({super.key, required this.recording});

  final Recording recording;

  @override
  State<RecordingPlayerPage> createState() => _RecordingPlayerPageState();
}

class _RecordingPlayerPageState extends State<RecordingPlayerPage> {
  int _activeChapterIndex = 0;
  bool _isPlaying = true;
  Duration _currentPosition = const Duration(seconds: 10);

  void _onChapterTap(int index) {
    setState(() {
      _activeChapterIndex = index;
      _currentPosition = widget.recording.chapters[index].startTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,

      body: Column(
        children: [
          RecordingPlayerView(
            recording: widget.recording,
            currentChapterIndex: _activeChapterIndex,
            currentPosition: _currentPosition,
            isPlaying: _isPlaying,
            onBack: () => maybeMoveBack(context),
            onTogglePlay: () => setState(() => _isPlaying = !_isPlaying),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RecordingInfoSection(
                    recording: widget.recording,
                    onShare: () {},
                    onDownload: () {},
                  ),
                  Divider(height: 1, thickness: 1, color: theme.borderDefault),
                  SizedBox(height: AppDimensions.spacingVerticalMd),
                  RecordingOverviewSection(
                    chapters: widget.recording.chapters,
                    activeChapterIndex: _activeChapterIndex,
                    onChapterTap: _onChapterTap,
                  ),
                  SizedBox(height: AppDimensions.spacingVertical3xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
