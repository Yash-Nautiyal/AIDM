import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileAvatarEditor extends StatelessWidget {
  const ProfileAvatarEditor({
    super.key,
    required this.displayName,
    this.onEditTap,
    this.avatarLetter,
  });

  final String displayName;
  final VoidCallback? onEditTap;
  final String? avatarLetter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final letter = avatarLetter ?? displayName.characters.first.toUpperCase();
    final avatarSize = 96.sp;
    final editButtonSize = 32.sp;

    return SizedBox(
      width: avatarSize,
      height: avatarSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.brandPrimary,
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
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onEditTap,
              child: Container(
                width: editButtonSize,
                height: editButtonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.brandPrimaryTint,
                  border: Border.all(color: theme.borderDefault, width: 1),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AppAssets.editIcon,
                  width: AppDimensions.iconSizeMd,
                  height: AppDimensions.iconSizeMd,
                  colorFilter: ColorFilter.mode(
                    theme.brandPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
