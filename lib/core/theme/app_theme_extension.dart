import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  // Brand
  final Color brandPrimary;
  final Color brandPurple;
  final Color brandPrimaryTint;
  final Color brandPurpleTint;

  // Shadow
  final List<BoxShadow> bottomNavShadow;
  final List<BoxShadow> buttonShadow;

  // Gradient
  final LinearGradient gradientBrandPurple;
  final LinearGradient gradientActiveBlue;
  final LinearGradient gradientYellow;
  final LinearGradient gradientBrandBlue;

  // Background
  final Color backgroundPage;
  final Color backgroundInput;
  final Color lightBlackScreen;
  final Color backgroundDarkSurface;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textLink;
  final Color textDanger;

  // Border & Separator
  final Color borderDefault;
  final Color borderFocus;
  final Color borderError;
  final Color borderDark;

  // Button
  final Color buttonBackgroundPrimary;
  final Color buttonBackgroundSecondary;
  final Color buttonBackgroundTertiary;
  final Color buttonTertiaryBorder;
  final Color buttonInactive;

  // Switch
  final Color switchTrack;
  final Color switchTrackActive;

  // Status
  final Color statusLive;
  final Color statusLiveTint;
  final Color statusUpcoming;
  final Color statusUpcomingTint;
  final Color statusScheduled;
  final Color statusPast;
  final Color statusPastTint;
  final Color statusRecording;
  final Color statusRecordingTint;
  final Color statusDraft;
  final Color statusDraftTint;

  const AppThemeExtension({
    required this.brandPrimary,
    required this.brandPurple,
    required this.brandPrimaryTint,
    required this.brandPurpleTint,
    required this.bottomNavShadow,
    required this.buttonShadow,
    required this.gradientBrandPurple,
    required this.gradientActiveBlue,
    required this.gradientYellow,
    required this.gradientBrandBlue,
    required this.backgroundPage,
    required this.backgroundInput,
    required this.lightBlackScreen,
    required this.backgroundDarkSurface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textLink,
    required this.textDanger,
    required this.borderDefault,
    required this.borderFocus,
    required this.borderError,
    required this.borderDark,
    required this.buttonBackgroundPrimary,
    required this.buttonBackgroundSecondary,
    required this.buttonBackgroundTertiary,
    required this.buttonTertiaryBorder,
    required this.buttonInactive,
    required this.switchTrack,
    required this.switchTrackActive,
    required this.statusLive,
    required this.statusLiveTint,
    required this.statusUpcoming,
    required this.statusUpcomingTint,
    required this.statusScheduled,
    required this.statusPast,
    required this.statusPastTint,
    required this.statusRecording,
    required this.statusRecordingTint,
    required this.statusDraft,
    required this.statusDraftTint,
  });

  // --- FACTORY GETTER: LIGHT THEME MAPPING ---
  static AppThemeExtension get light => AppThemeExtension(
    brandPrimary: AppColors.brandPrimary,
    brandPurple: AppColors.brandPurple,
    brandPrimaryTint: AppColors.brandPrimaryTint,
    brandPurpleTint: AppColors.brandPurpleTint,
    bottomNavShadow: AppColors.lightBottomNavShadow,
    buttonShadow: AppColors.lightButtonShadow,
    gradientBrandPurple: AppColors.gradientBrandPurple,
    gradientActiveBlue: AppColors.gradientActiveBlue,
    gradientYellow: AppColors.gradientYellow,
    gradientBrandBlue: AppColors.gradientBrandBlue,
    backgroundPage: AppColors.lightBgPage,
    backgroundInput: AppColors.lightBgInput,
    lightBlackScreen: AppColors.lightBlackScreen,
    backgroundDarkSurface: AppColors.bgDarkSurface,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    textTertiary: AppColors.lightTextTertiary,
    textLink: AppColors.textLink,
    textDanger: AppColors.textDanger,
    borderDefault: AppColors.lightBorderDefault,
    borderFocus: AppColors.borderFocus,
    borderError: AppColors.borderError,
    borderDark: AppColors.borderDark,
    buttonBackgroundPrimary: AppColors.buttonBackgroundPrimary,
    buttonBackgroundSecondary: AppColors.buttonBackgroundSecondary,
    buttonBackgroundTertiary: AppColors.buttonBackgroundTertiary,
    buttonTertiaryBorder: AppColors.buttonTertiaryBorder,
    buttonInactive: AppColors.lightButtonInactive,
    switchTrack: AppColors.switchTrack,
    switchTrackActive: AppColors.switchTrackActive,
    statusLive: AppColors.statusLive,
    statusLiveTint: AppColors.statusLiveTint,
    statusUpcoming: AppColors.statusUpcoming,
    statusUpcomingTint: AppColors.statusUpcomingTint,
    statusScheduled: AppColors.statusScheduled,
    statusPast: AppColors.statusPast,
    statusPastTint: AppColors.statusPastTint,
    statusRecording: AppColors.statusRecording,
    statusRecordingTint: AppColors.statusRecordingTint,
    statusDraft: AppColors.statusDraft,
    statusDraftTint: AppColors.statusDraftTint,
  );

  // --- FACTORY GETTER: DARK THEME MAPPING ---
  static AppThemeExtension get dark => AppThemeExtension(
    brandPrimary: AppColors.brandPrimary,
    brandPurple: AppColors.brandPurple,
    brandPrimaryTint: AppColors.brandPrimaryTint,
    brandPurpleTint: AppColors.brandPurpleTint,
    bottomNavShadow: AppColors.darkBottomNavShadow,
    buttonShadow: AppColors.darkButtonShadow,
    gradientBrandPurple: AppColors.gradientBrandPurple,
    gradientActiveBlue: AppColors.gradientActiveBlue,
    gradientYellow: AppColors.gradientYellow,
    gradientBrandBlue: AppColors.gradientBrandBlue,
    backgroundPage: AppColors.darkBgPage,
    backgroundInput: AppColors.darkBgInput,
    lightBlackScreen: AppColors.lightBlackScreen,
    backgroundDarkSurface: AppColors.bgDarkSurface,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    textTertiary: AppColors.darkTextTertiary,
    textLink: AppColors.textLink,
    textDanger: AppColors.textDanger,
    borderDefault: AppColors.darkBorderDefault,
    borderFocus: AppColors.borderFocus,
    borderError: AppColors.borderError,
    borderDark: AppColors.borderDark,
    buttonBackgroundPrimary: AppColors.buttonBackgroundPrimary,
    buttonBackgroundSecondary: AppColors.buttonBackgroundSecondary,
    buttonBackgroundTertiary: AppColors.buttonBackgroundTertiary,
    buttonTertiaryBorder: AppColors.buttonTertiaryBorder,
    buttonInactive: AppColors.darkButtonInactive,
    switchTrack: AppColors.switchTrack,
    switchTrackActive: AppColors.switchTrackActive,
    statusLive: AppColors.statusLive,
    statusLiveTint: AppColors.statusLiveTint,
    statusUpcoming: AppColors.statusUpcoming,
    statusUpcomingTint: AppColors.statusUpcomingTint,
    statusScheduled: AppColors.statusScheduled,
    statusPast: AppColors.statusPast,
    statusPastTint: AppColors.statusPastTint,
    statusRecording: AppColors.statusRecording,
    statusRecordingTint: AppColors.statusRecordingTint,
    statusDraft: AppColors.statusDraft,
    statusDraftTint: AppColors.statusDraftTint,
  );

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? brandPrimary,
    Color? brandPurple,
    Color? brandPrimaryTint,
    Color? brandPurpleTint,
    List<BoxShadow>? bottomNavShadow,
    List<BoxShadow>? buttonShadow,
    LinearGradient? gradientBrandPurple,
    LinearGradient? gradientActiveBlue,
    LinearGradient? gradientYellow,
    LinearGradient? gradientBrandBlue,
    Color? backgroundPage,
    Color? backgroundInput,
    Color? lightBlackScreen,
    Color? backgroundDarkSurface,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textLink,
    Color? textDanger,
    Color? borderDefault,
    Color? borderFocus,
    Color? borderError,
    Color? borderDark,
    Color? buttonBackgroundPrimary,
    Color? buttonBackgroundSecondary,
    Color? buttonBackgroundTertiary,
    Color? buttonTertiaryBorder,
    Color? buttonInactive,
    Color? switchTrack,
    Color? switchTrackActive,
    Color? statusLive,
    Color? statusLiveTint,
    Color? statusUpcoming,
    Color? statusUpcomingTint,
    Color? statusScheduled,
    Color? statusPast,
    Color? statusPastTint,
    Color? statusRecording,
    Color? statusRecordingTint,
    Color? statusDraft,
    Color? statusDraftTint,
  }) {
    return AppThemeExtension(
      brandPrimary: brandPrimary ?? this.brandPrimary,
      brandPurple: brandPurple ?? this.brandPurple,
      brandPrimaryTint: brandPrimaryTint ?? this.brandPrimaryTint,
      brandPurpleTint: brandPurpleTint ?? this.brandPurpleTint,
      bottomNavShadow: bottomNavShadow ?? this.bottomNavShadow,
      buttonShadow: buttonShadow ?? this.buttonShadow,
      gradientBrandPurple: gradientBrandPurple ?? this.gradientBrandPurple,
      gradientActiveBlue: gradientActiveBlue ?? this.gradientActiveBlue,
      gradientYellow: gradientYellow ?? this.gradientYellow,
      gradientBrandBlue: gradientBrandBlue ?? this.gradientBrandBlue,
      backgroundPage: backgroundPage ?? this.backgroundPage,
      backgroundInput: backgroundInput ?? this.backgroundInput,
      lightBlackScreen: lightBlackScreen ?? this.lightBlackScreen,
      backgroundDarkSurface:
          backgroundDarkSurface ?? this.backgroundDarkSurface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textLink: textLink ?? this.textLink,
      textDanger: textDanger ?? this.textDanger,
      borderDefault: borderDefault ?? this.borderDefault,
      borderFocus: borderFocus ?? this.borderFocus,
      borderError: borderError ?? this.borderError,
      borderDark: borderDark ?? this.borderDark,
      buttonBackgroundPrimary:
          buttonBackgroundPrimary ?? this.buttonBackgroundPrimary,
      buttonBackgroundSecondary:
          buttonBackgroundSecondary ?? this.buttonBackgroundSecondary,
      buttonBackgroundTertiary:
          buttonBackgroundTertiary ?? this.buttonBackgroundTertiary,
      buttonTertiaryBorder: buttonTertiaryBorder ?? this.buttonTertiaryBorder,
      buttonInactive: buttonInactive ?? this.buttonInactive,
      switchTrack: switchTrack ?? this.switchTrack,
      switchTrackActive: switchTrackActive ?? this.switchTrackActive,
      statusLive: statusLive ?? this.statusLive,
      statusLiveTint: statusLiveTint ?? this.statusLiveTint,
      statusUpcoming: statusUpcoming ?? this.statusUpcoming,
      statusUpcomingTint: statusUpcomingTint ?? this.statusUpcomingTint,
      statusScheduled: statusScheduled ?? this.statusScheduled,
      statusPast: statusPast ?? this.statusPast,
      statusPastTint: statusPastTint ?? this.statusPastTint,
      statusRecording: statusRecording ?? this.statusRecording,
      statusRecordingTint: statusRecordingTint ?? this.statusRecordingTint,
      statusDraft: statusDraft ?? this.statusDraft,
      statusDraftTint: statusDraftTint ?? this.statusDraftTint,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      brandPrimary: Color.lerp(brandPrimary, other.brandPrimary, t)!,
      brandPurple: Color.lerp(brandPurple, other.brandPurple, t)!,
      brandPrimaryTint: Color.lerp(
        brandPrimaryTint,
        other.brandPrimaryTint,
        t,
      )!,
      brandPurpleTint: Color.lerp(brandPurpleTint, other.brandPurpleTint, t)!,
      bottomNavShadow:
          BoxShadow.lerpList(bottomNavShadow, other.bottomNavShadow, t) ?? [],
      buttonShadow:
          BoxShadow.lerpList(buttonShadow, other.buttonShadow, t) ?? [],
      gradientBrandPurple: LinearGradient.lerp(
        gradientBrandPurple,
        other.gradientBrandPurple,
        t,
      )!,
      gradientActiveBlue: LinearGradient.lerp(
        gradientActiveBlue,
        other.gradientActiveBlue,
        t,
      )!,
      gradientYellow: LinearGradient.lerp(
        gradientYellow,
        other.gradientYellow,
        t,
      )!,
      gradientBrandBlue: LinearGradient.lerp(
        gradientBrandBlue,
        other.gradientBrandBlue,
        t,
      )!,
      backgroundPage: Color.lerp(backgroundPage, other.backgroundPage, t)!,
      backgroundInput: Color.lerp(backgroundInput, other.backgroundInput, t)!,
      lightBlackScreen: Color.lerp(
        lightBlackScreen,
        other.lightBlackScreen,
        t,
      )!,
      backgroundDarkSurface: Color.lerp(
        backgroundDarkSurface,
        other.backgroundDarkSurface,
        t,
      )!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textLink: Color.lerp(textLink, other.textLink, t)!,
      textDanger: Color.lerp(textDanger, other.textDanger, t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      borderFocus: Color.lerp(borderFocus, other.borderFocus, t)!,
      borderError: Color.lerp(borderError, other.borderError, t)!,
      borderDark: Color.lerp(borderDark, other.borderDark, t)!,
      buttonBackgroundPrimary: Color.lerp(
        buttonBackgroundPrimary,
        other.buttonBackgroundPrimary,
        t,
      )!,
      buttonBackgroundSecondary: Color.lerp(
        buttonBackgroundSecondary,
        other.buttonBackgroundSecondary,
        t,
      )!,
      buttonBackgroundTertiary: Color.lerp(
        buttonBackgroundTertiary,
        other.buttonBackgroundTertiary,
        t,
      )!,
      buttonTertiaryBorder: Color.lerp(
        buttonTertiaryBorder,
        other.buttonTertiaryBorder,
        t,
      )!,
      buttonInactive: Color.lerp(buttonInactive, other.buttonInactive, t)!,
      switchTrack: Color.lerp(switchTrack, other.switchTrack, t)!,
      switchTrackActive: Color.lerp(
        switchTrackActive,
        other.switchTrackActive,
        t,
      )!,
      statusLive: Color.lerp(statusLive, other.statusLive, t)!,
      statusLiveTint: Color.lerp(statusLiveTint, other.statusLiveTint, t)!,
      statusUpcoming: Color.lerp(statusUpcoming, other.statusUpcoming, t)!,
      statusUpcomingTint: Color.lerp(
        statusUpcomingTint,
        other.statusUpcomingTint,
        t,
      )!,
      statusScheduled: Color.lerp(statusScheduled, other.statusScheduled, t)!,
      statusPast: Color.lerp(statusPast, other.statusPast, t)!,
      statusPastTint: Color.lerp(statusPastTint, other.statusPastTint, t)!,
      statusRecording: Color.lerp(statusRecording, other.statusRecording, t)!,
      statusRecordingTint: Color.lerp(
        statusRecordingTint,
        other.statusRecordingTint,
        t,
      )!,
      statusDraft: Color.lerp(statusDraft, other.statusDraft, t)!,
      statusDraftTint: Color.lerp(statusDraftTint, other.statusDraftTint, t)!,
    );
  }
}
