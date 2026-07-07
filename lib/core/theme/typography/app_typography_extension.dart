import 'package:flutter/material.dart';
import 'app_typography.dart';
import '../app_colors.dart';

class AppTypographyExtension extends ThemeExtension<AppTypographyExtension> {
  final TextStyle display;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;

  final TextStyle bodyLarge;
  final TextStyle bodyMedium16;
  final TextStyle body16;
  final TextStyle body;
  final TextStyle bodyMedium;
  final TextStyle bodySemibold;
  final TextStyle bodyCompact;
  final TextStyle bodyXSmall;

  final TextStyle labelLarge;
  final TextStyle label;
  final TextStyle labelMedium;
  final TextStyle labelSmall;
  final TextStyle captionBold;
  final TextStyle caption;
  final TextStyle captionLight;
  final TextStyle nav;

  const AppTypographyExtension({
    required this.display,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.bodyLarge,
    required this.bodyMedium16,
    required this.body16,
    required this.body,
    required this.bodyMedium,
    required this.bodySemibold,
    required this.bodyCompact,
    required this.bodyXSmall,
    required this.labelLarge,
    required this.label,
    required this.labelMedium,
    required this.labelSmall,
    required this.captionBold,
    required this.caption,
    required this.captionLight,
    required this.nav,
  });

  static AppTypographyExtension get light => _build(AppColors.lightTextPrimary);

  static AppTypographyExtension get dark => _build(AppColors.darkTextPrimary);

  static AppTypographyExtension _build(Color defaultColor) {
    return AppTypographyExtension(
      display: AppTypography.display.copyWith(color: defaultColor),
      h1: AppTypography.h1.copyWith(color: defaultColor),
      h2: AppTypography.h2.copyWith(color: defaultColor),
      h3: AppTypography.h3.copyWith(color: defaultColor),
      h4: AppTypography.h4.copyWith(color: defaultColor),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: defaultColor),
      bodyMedium16: AppTypography.bodyMedium16.copyWith(color: defaultColor),
      body16: AppTypography.body16.copyWith(color: defaultColor),
      body: AppTypography.body.copyWith(color: defaultColor),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: defaultColor),
      bodySemibold: AppTypography.bodySemibold.copyWith(color: defaultColor),
      bodyCompact: AppTypography.bodyCompact.copyWith(color: defaultColor),
      bodyXSmall: AppTypography.bodyXSmall.copyWith(color: defaultColor),
      labelLarge: AppTypography.labelLarge.copyWith(color: defaultColor),
      label: AppTypography.label.copyWith(color: defaultColor),
      labelMedium: AppTypography.labelMedium.copyWith(color: defaultColor),
      labelSmall: AppTypography.labelSmall.copyWith(color: defaultColor),
      captionBold: AppTypography.captionBold.copyWith(color: defaultColor),
      caption: AppTypography.caption.copyWith(color: defaultColor),
      captionLight: AppTypography.captionLight.copyWith(color: defaultColor),
      nav: AppTypography.nav.copyWith(color: defaultColor),
    );
  }

  @override
  ThemeExtension<AppTypographyExtension> copyWith({
    TextStyle? display,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium16,
    TextStyle? body16,
    TextStyle? body,
    TextStyle? bodyMedium,
    TextStyle? bodySemibold,
    TextStyle? bodyCompact,
    TextStyle? bodyXSmall,
    TextStyle? labelLarge,
    TextStyle? label,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? captionBold,
    TextStyle? caption,
    TextStyle? captionLight,
    TextStyle? nav,
  }) {
    return AppTypographyExtension(
      display: display ?? this.display,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium16: bodyMedium16 ?? this.bodyMedium16,
      body16: body16 ?? this.body16,
      body: body ?? this.body,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySemibold: bodySemibold ?? this.bodySemibold,
      bodyCompact: bodyCompact ?? this.bodyCompact,
      bodyXSmall: bodyXSmall ?? this.bodyXSmall,
      labelLarge: labelLarge ?? this.labelLarge,
      label: label ?? this.label,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      captionBold: captionBold ?? this.captionBold,
      caption: caption ?? this.caption,
      captionLight: captionLight ?? this.captionLight,
      nav: nav ?? this.nav,
    );
  }

  @override
  ThemeExtension<AppTypographyExtension> lerp(
    covariant ThemeExtension<AppTypographyExtension>? other,
    double t,
  ) {
    if (other is! AppTypographyExtension) return this;
    return AppTypographyExtension(
      display: TextStyle.lerp(display, other.display, t)!,
      h1: TextStyle.lerp(h1, other.h1, t)!,
      h2: TextStyle.lerp(h2, other.h2, t)!,
      h3: TextStyle.lerp(h3, other.h3, t)!,
      h4: TextStyle.lerp(h4, other.h4, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium16: TextStyle.lerp(bodyMedium16, other.bodyMedium16, t)!,
      body16: TextStyle.lerp(body16, other.body16, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySemibold: TextStyle.lerp(bodySemibold, other.bodySemibold, t)!,
      bodyCompact: TextStyle.lerp(bodyCompact, other.bodyCompact, t)!,
      bodyXSmall: TextStyle.lerp(bodyXSmall, other.bodyXSmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
      captionBold: TextStyle.lerp(captionBold, other.captionBold, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      captionLight: TextStyle.lerp(captionLight, other.captionLight, t)!,
      nav: TextStyle.lerp(nav, other.nav, t)!,
    );
  }
}
