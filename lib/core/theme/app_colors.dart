import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color brandPrimary = Color(0xFF3762E3);
  static const Color brandPurple = Color(0xFF6648FA);
  static const Color brandPrimaryTint = Color(0xFFFFFFFF);
  static const Color brandPurpleTint = Color(0xFFEDE8FE);

  //Gradient
  static const LinearGradient gradientBrandPurple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3762E3), Color(0xFF6647FA)],
    stops: [0.0365, 1.1513],
  );

  static const LinearGradient gradientActiveBlue = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [Color(0xFF3086FD), Color(0xFF1333E0)],
    stops: [0.0468, 0.9958],
  );

  static const LinearGradient gradientYellow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFED001), Color(0xFFFFA90A)],
    stops: [0.0824, 0.9373],
  );

  static const LinearGradient gradientBrandBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6189FF), Color(0xFF3762E3)],
    stops: [0.0684, 0.9904],
  );

  // Status
  static const Color statusLive = Color(0xFFEF3838);
  static const Color statusLiveTint = Color(0xFFFEF0F0);
  static const Color statusUpcoming = Color(0xFF3B5BDB);
  static const Color statusUpcomingTint = Color(0xFFEEF2FF);
  static const Color statusScheduled = Color(0xFF3B5BDB);
  static const Color statusPast = Color(0xFFB8B8BC);
  static const Color statusPastTint = Color(0xFFF6F6F7);
  static const Color statusRecording = Color(0xFF6648FA);
  static const Color statusRecordingTint = Color(0xFFEDE8FE);
  static const Color statusDraft = Color(0xFFF59E0B);
  static const Color statusDraftTint = Color(0xFFFEF9EE);

  // Switch colors
  static const Color switchTrack = Color(0xFFB8B8BD);
  static const Color switchTrackActive = Color(0xFF30C516);

  // Shared UI elements
  static const Color lightBlackScreen = Color(0xFF000000);
  static const Color bgDarkSurface = Color(0xFF1C1C1E);
  static const Color textLink = Color(0xFF3B5BDB);
  static const Color textDanger = Color(0xFFEF3838);
  static const Color borderFocus = Color(0xFF3B5BDB);
  static const Color borderError = Color(0xFFEF3838);
  static const Color borderDark = Color(0xFF3A3A3C);

  //Text colors
  static const Color textPrimary = Color(0xFF111113);
  static const Color textSecondary = Color(0xFF737378);

  // Button backgrounds
  static Color get buttonBackgroundPrimary => brandPrimary;
  static const Color buttonBackgroundSecondary = Color(0xFF3B5BDB);
  static const Color buttonBackgroundTertiary = Color(0xFFFFFFFF);
  static const Color buttonTertiaryBorder = Color(0xFFE8E8ED);

  // ---------------------------------------------------------------------------
  // LIGHT MODE COLORS
  // ---------------------------------------------------------------------------

  static Color get lightBgPage => const Color(0xFFFFFFFF);
  static Color get lightBgInput => const Color(0xFFF6F6F7);
  static Color get lightTextPrimary => const Color(0xFF111113);
  static Color get lightTextSecondary => const Color(0xFF737378);
  static Color get lightTextTertiary => const Color(0xFFB8B8BC);
  static Color get lightBorderDefault => const Color(0xFFE8E8EA);
  static Color get lightButtonInactive => const Color(0xFFD4D4D4);

  static List<BoxShadow> get lightBottomNavShadow => [
    BoxShadow(
      color: const Color(0x08000000),
      blurRadius: 24,
      offset: const Offset(0, -5),
      spreadRadius: 0,
    ),
  ];
  static List<BoxShadow> get lightButtonShadow => [
    BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  // ---------------------------------------------------------------------------
  // DARK MODE COLORS
  // ---------------------------------------------------------------------------

  static Color get darkBgPage => const Color(0xFF000000);
  static Color get darkBgInput => const Color(0xFF1E1E1E);
  static Color get darkTextPrimary => const Color(0xFFFFFFFF);
  static Color get darkTextSecondary => const Color(0xFF8E8E93);
  static Color get darkTextTertiary => const Color(0xFF525253);
  static Color get darkBorderDefault => const Color(0xFF404040);
  static Color get darkButtonInactive => const Color(0xFF393939);

  static List<BoxShadow> get darkBottomNavShadow => [
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.30),
      blurRadius: 24,
      offset: const Offset(0, -5),
    ),
  ];
  static List<BoxShadow> get darkButtonShadow => [
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.30),
      blurRadius: 24,
      offset: const Offset(0, -5),
    ),
  ];
}
