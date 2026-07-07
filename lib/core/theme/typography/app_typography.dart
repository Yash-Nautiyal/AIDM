import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static const String fontFamily = 'PlusJakartaSans';

  // HEADLINE
  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 44,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 35,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 18 / 18, // 1.0
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 18 / 20, // 0.9
  );

  // BODY
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 25 / 18,
  );

  static const TextStyle bodyMedium16 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body16 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 20 / 16,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodySemibold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyCompact = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 19 / 12,
  );

  static const TextStyle bodyXSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  // LABELS & CAPTIONS
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 24 / 16,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle captionBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 18 / 12,
  );

  static const TextStyle captionLight = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle nav = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
}
