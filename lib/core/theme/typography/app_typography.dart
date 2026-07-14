import 'package:flutter/material.dart';
import '../../utils/app/responsive_extension.dart';

class AppTypography {
  AppTypography._();

  static const String fontFamily = 'PlusJakartaSans';

  // HEADLINE
  static TextStyle get display => TextStyle(
    fontFamily: fontFamily,
    fontSize: 44.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get h1 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 35.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get h2 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 26.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get h3 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    height: 18 / 18, // Line height multiplier remains unscaled
  );

  static TextStyle get h4 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    height: 18 / 20,
  );

  // BODY
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    height: 25 / 18,
  );

  static TextStyle get bodyMedium16 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get body16 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 20 / 16,
  );

  static TextStyle get body => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get bodySemibold => TextStyle(
    fontFamily: fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get bodyCompact => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 19 / 12,
  );

  static TextStyle get bodyXSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
  );

  // LABELS & CAPTIONS
  static TextStyle get labelLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get label => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 24 / 16,
  );

  static TextStyle get labelMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get labelSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get captionBold => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get caption => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 18 / 12,
  );

  static TextStyle get captionLight => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get nav => TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
  );
}
