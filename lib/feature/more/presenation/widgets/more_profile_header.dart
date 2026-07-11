import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';

class MoreProfileHeader extends StatelessWidget {
  const MoreProfileHeader({
    super.key,
    required this.displayName,
    required this.email,
    required this.joinedDate,
    this.avatarLetter,
  });

  final String displayName;
  final String email;
  final String joinedDate;
  final String? avatarLetter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final letter = avatarLetter ?? displayName.characters.first.toUpperCase();

    return Column(
      children: [
        Container(
          width: 88.sp,
          height: 88.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: theme.gradientBrandPurple,
          ),
          alignment: Alignment.center,
          child: Text(
            letter,
            style: typography.h1.copyWith(
              color: theme.brandPrimaryTint,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: AppDimensions.spacingVerticalLg),
        Text(
          displayName,
          style: typography.h3.copyWith(color: theme.textPrimary),
        ),
        SizedBox(height: AppDimensions.spacingVerticalXs),
        Text(
          email,
          style: typography.bodyMedium.copyWith(color: theme.textSecondary),
        ),
        SizedBox(height: AppDimensions.spacingVerticalXs),
        Text(
          joinedDate,
          style: typography.bodyMedium.copyWith(color: theme.textSecondary),
        ),
      ],
    );
  }
}
