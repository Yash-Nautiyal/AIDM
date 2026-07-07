import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_theme_extension.dart';
import 'typography/app_typography.dart';
import 'typography/app_typography_extension.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'PlusJakartaSans',
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBgPage,
      textTheme:
          TextTheme(
            displayLarge: AppTypography.display,
            headlineSmall: AppTypography.h3,
            bodyLarge: AppTypography.bodyLarge,
            bodyMedium: AppTypography.body,
            labelLarge: AppTypography.labelLarge,
          ).apply(
            bodyColor: AppColors.lightTextPrimary,
            displayColor: AppColors.lightTextPrimary,
          ),
      extensions: <ThemeExtension<dynamic>>[
        AppThemeExtension.light,
        AppTypographyExtension.light,
      ],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'PlusJakartaSans',
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBgPage,
      textTheme:
          TextTheme(
            displayLarge: AppTypography.display,
            headlineSmall: AppTypography.h3,
            bodyLarge: AppTypography.bodyLarge,
            bodyMedium: AppTypography.body,
            labelLarge: AppTypography.labelLarge,
          ).apply(
            bodyColor: AppColors.darkTextPrimary,
            displayColor: AppColors.darkTextPrimary,
          ),
      extensions: <ThemeExtension<dynamic>>[
        AppThemeExtension.dark,
        AppTypographyExtension.dark,
      ],
    );
  }
}
