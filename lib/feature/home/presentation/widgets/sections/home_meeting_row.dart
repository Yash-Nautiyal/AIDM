import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum HomeQuickActionType { start, join, schedule, recordings }

class HomeMeetingRow extends StatelessWidget {
  const HomeMeetingRow({
    super.key,
    this.onStartTap,
    this.onJoinTap,
    this.onScheduleTap,
    this.onRecordingsTap,
  });

  final VoidCallback? onStartTap;
  final VoidCallback? onJoinTap;
  final VoidCallback? onScheduleTap;
  final VoidCallback? onRecordingsTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    final actions = <_HomeQuickAction>[
      _HomeQuickAction(
        type: HomeQuickActionType.start,
        label: 'Start',
        icon: AppAssets.recorderIcon,
        background: theme.gradientYellow,
        onTap: onStartTap,
      ),
      _HomeQuickAction(
        type: HomeQuickActionType.join,
        label: 'Join',
        icon: AppAssets.addIcon,
        background: theme.gradientBrandBlue,
        onTap: onJoinTap,
      ),
      _HomeQuickAction(
        type: HomeQuickActionType.schedule,
        label: 'Schedule',
        icon: AppAssets.calendar1Icon,
        background: theme.gradientBrandBlue,
        onTap: onScheduleTap,
      ),
      _HomeQuickAction(
        type: HomeQuickActionType.recordings,
        label: 'Recordings',
        icon: AppAssets.recordingIcon,
        background: theme.gradientBrandBlue,
        onTap: onRecordingsTap,
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions
          .map(
            (a) => Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingXs,
                ),
                child: _HomeQuickActionTile(action: a),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _HomeQuickAction {
  const _HomeQuickAction({
    required this.type,
    required this.label,
    required this.icon,
    required this.background,
    required this.onTap,
  });

  final HomeQuickActionType type;
  final String label;
  final String icon;
  final Gradient background;
  final VoidCallback? onTap;
}

class _HomeQuickActionTile extends StatelessWidget {
  const _HomeQuickActionTile({required this.action});

  final _HomeQuickAction action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action.onTap,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            splashColor: Colors.white.withValues(alpha: 0.12),
            highlightColor: Colors.white.withValues(alpha: 0.08),
            child: Ink(
              height: 60.h,
              width: 60.h,
              decoration: BoxDecoration(
                gradient: action.background,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              ),
              child: Center(
                child: SvgPicture.asset(
                  action.icon,
                  alignment: Alignment.center,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: AppDimensions.spacingSm),
        Text(
          action.label,
          style: typography.caption.copyWith(color: theme.textSecondary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
