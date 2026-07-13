import 'package:flutter/material.dart';

import '../utils/responsive_extension.dart';

abstract final class AppDimensions {
  // Page layou
  static double get spacingXs => 4.w;
  static double get spacingSm => 8.w;
  static double get spacingMd => 12.w;
  static double get spacingLg => 16.w;
  static double get spacingXl => 20.w;
  static double get spacing2xl => 24.w;
  static double get spacing3xl => 32.w;

  //Padding Vertical
  static double get spacingVerticalXs => 4.h;
  static double get spacingVerticalSm => 8.h;
  static double get spacingVerticalMd => 12.h;
  static double get spacingVerticalLg => 16.h;
  static double get spacingVerticalXl => 20.h;
  static double get spacingVertical2xl => 24.h;
  static double get spacingVertical3xl => 32.h;

  //Padding
  static EdgeInsets get pagePadding => EdgeInsets.fromLTRB(
    AppDimensions.spacing2xl,
    AppDimensions.spacingVerticalLg,
    AppDimensions.spacing2xl,
    AppDimensions.spacingVerticalLg,
  );

  // Button
  static double get buttonHeight => 50.sp;
  static double get buttonHeightMd => 40.h;
  static double get buttonHeightSm => 30.h;

  // App bar
  static double get appBarHeight => 56.h;
  static double get appBarBottomPadding => spacingVerticalMd;
  static double get appBarTotalHeight => appBarHeight + appBarBottomPadding;

  // Nav bar
  static double get navBarHeight => 74.sp;
  static double get navIconSize => 20.sp;
  static double get navPillHorizontalPadding => 16.sp;
  static double get navPillVerticalPadding => 8.sp;
  static double get navPillRadius => 20.r;
  static double get navItemRadius => 12.r;

  // Nav text math
  static double get navLabelFontSize => 12.sp;
  static double get navLabelLineHeight => 1.2;
  static double get navLabelGap => 4.sp;
  static double get navLabelHeight => navLabelFontSize * navLabelLineHeight;

  // Computed layout bounds
  static double get navPillHeight => navIconSize + navPillVerticalPadding * 2;
  static double get navPillWidth => navIconSize + navPillHorizontalPadding * 2;
  static double get navContentHeight =>
      navPillHeight + navLabelGap + navLabelHeight;

  // Radius
  static double get radiusSm => 9.r;
  static double get radiusMd => 12.r;
  static double get radiusLg => 16.r;
  static double get radiusXl => 20.r;
  static double get radius2xl => 24.r;
  static double get radius3xl => 28.r;

  // OTP input
  static double get otpBoxWidth => 55.w;
  static double get otpBoxHeight => 58.h;
  static double get otpBoxRadius => 12.r;
  static double get otpBoxGap => 10.w;
  static const double otpBoxBorderWidth = 0.8;
  static double get otpBoxPaddingVertical => 11.h;
  static double get otpBoxPaddingHorizontal => 25.w;

  //logo
  static double get logoWidth => 150.sp;
  static double get logoHeight => 100.sp;

  // Notification
  static double get notificationAvatarRadius => 23.sp;
  static double get notificationEventAvatarRadius => 27.sp;

  // Icon
  static double get iconSizeXs => 10.sp;
  static double get iconSizeSm => 12.sp;
  static double get iconSizeMd => 16.sp;
  static double get iconSizeLg => 20.sp;
  static double get iconSizeXl => 28.sp;
}
