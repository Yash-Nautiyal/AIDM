import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSystemDialog extends StatelessWidget {
  const AppSystemDialog({
    super.key,
    required this.title,
    required this.description,
    this.onClose,
  });

  final String title;
  final String description;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Container(
      padding: EdgeInsets.all(AppDimensions.spacingLg),
      decoration: BoxDecoration(
        color: theme.backgroundInput,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: typography.captionBold),

              if (onClose != null)
                InkWell(
                  onTap: onClose,
                  child: SvgPicture.asset(
                    AppAssets.closeIcon,
                    width: AppDimensions.iconSizeSm,
                    height: AppDimensions.iconSizeSm,
                    colorFilter: ColorFilter.mode(
                      theme.textSecondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: AppDimensions.spacingVerticalSm),
          Text(
            description,
            style: typography.captionLight.copyWith(color: theme.textSecondary),
          ),
        ],
      ),
    );
  }
}
