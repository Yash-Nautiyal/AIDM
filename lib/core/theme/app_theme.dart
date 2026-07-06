import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_theme_extension.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBgPage,
      extensions: <ThemeExtension<dynamic>>[AppThemeExtension.light],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBgPage,
      extensions: <ThemeExtension<dynamic>>[AppThemeExtension.dark],
    );
  }
}
