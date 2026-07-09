import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.userName,
    this.onNotificationsTap,
  });

  final String userName;
  final VoidCallback? onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Row(
      children: [
        CircleAvatar(radius: AppDimensions.radiusXl),
        SizedBox(width: AppDimensions.spacingMd),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, Welcome',
                style: typography.bodyCompact.copyWith(
                  color: theme.textSecondary,
                ),
              ),
              Text(
                userName,
                style: typography.h3.copyWith(color: theme.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SvgPicture.asset(
          AppAssets.notificationIcon,
          alignment: Alignment.center,
          height: 24.h,
          colorFilter: ColorFilter.mode(theme.textPrimary, BlendMode.srcIn),
        ),
      ],
    );
  }
}
