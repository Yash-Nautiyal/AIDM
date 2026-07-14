import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:aidm/core/widgets/input/app_input1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarSearchBar extends StatelessWidget {
  const CalendarSearchBar({
    super.key,
    required this.controller,
    required this.onCancel,
    this.onChanged,
  });

  final TextEditingController controller;
  final VoidCallback onCancel;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Padding(
      padding: AppDimensions.pagePadding,
      child: Row(
        children: [
          Expanded(
            child: AppInput(
              controller: controller,
              hintText: 'Search',
              onChanged: onChanged,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 8.w),
                child: SvgPicture.asset(
                  AppAssets.searchIcon,
                  width: AppDimensions.iconSizeMd,
                  height: AppDimensions.iconSizeMd,
                  colorFilter: ColorFilter.mode(
                    theme.textTertiary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: AppDimensions.spacingMd),
          TextButton(
            onPressed: onCancel,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Cancel',
              style: typography.bodyMedium.copyWith(color: theme.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
