// import 'package:aidm/core/constant/app_assets.dart';
// import 'package:aidm/core/constant/app_dimensions.dart';
// import 'package:aidm/core/theme/app_theme_extension.dart';
// import 'package:aidm/core/utils/responsive_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CalendarSearchActionButton extends StatelessWidget {
//   const CalendarSearchActionButton({super.key, required this.onPressed});

//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).extension<AppThemeExtension>()!;

//     return Padding(
//       padding: EdgeInsets.only(right: AppDimensions.spacingLg),
//       child: Material(
//         color: theme.brandPrimary,
//         shape: const CircleBorder(),
//         elevation: 2,
//         shadowColor: theme.brandPrimary.withValues(alpha: 0.3),
//         child: InkWell(
//           onTap: onPressed,
//           customBorder: const CircleBorder(),
//           child: SizedBox(
//             width: 40.sp,
//             height: 40.sp,
//             child: Center(
//               child: SvgPicture.asset(
//                 AppAssets.searchIcon,
//                 width: AppDimensions.iconSizeMd,
//                 height: AppDimensions.iconSizeMd,
//                 colorFilter: ColorFilter.mode(
//                   theme.brandPrimaryTint,
//                   BlendMode.srcIn,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
