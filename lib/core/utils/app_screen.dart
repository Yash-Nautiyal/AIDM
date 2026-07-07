import 'dart:math';

import 'package:flutter/material.dart';

class AppScreen {
  static late double screenWidth;
  static late double screenHeight;

  static const double designWidth = 428;
  static const double designHeight = 955;

  static void init(BuildContext context) {
    final size =
        MediaQuery.maybeSizeOf(context) ??
        MediaQueryData.fromView(View.of(context)).size;
    _setSize(size);
    print('screenWidth: $screenWidth');
    print('screenHeight: $screenHeight');
    print('scaleWidth: $scaleWidth');
    print('scaleHeight: $scaleHeight');
    print('scaleText: $scaleText');
  }

  static void _setSize(Size size) {
    screenWidth = size.width;
    screenHeight = size.height;
  }

  static double get scaleWidth => screenWidth / designWidth;

  static double get scaleHeight => screenHeight / designHeight;

  static double get scaleText => min(scaleWidth, scaleHeight);

  static double setWidth(num width) => width * scaleWidth;
  static double setHeight(num height) => height * scaleHeight;
  static double setSp(num fontSize) => fontSize * scaleText;
  static double setRadius(num radius) => radius * scaleText;
}

class AppScreenScope extends StatelessWidget {
  const AppScreenScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    AppScreen.init(context);
    return child;
  }
}
