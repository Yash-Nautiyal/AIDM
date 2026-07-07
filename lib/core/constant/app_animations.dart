import 'package:flutter/material.dart';

abstract final class AppAnimations {
  static const Duration navDuration = Duration(milliseconds: 280);
  static const Duration contentDuration = Duration(milliseconds: 300);

  static const Curve standardCurve = Curves.easeOutCubic;
  static const Curve exitCurve = Curves.easeInCubic;

  static const double navSelectedScale = 1.06;
  static const double contentSlideOffset = 0.03;
  static const double titleSlideOffset = 0.25;
}
