import '../utils/responsive_extension.dart';

abstract final class AppDimensions {
  // Page layout
  static double get pagePadding => 24.w;
  static double get spacingXs => 4.w;
  static double get spacingSm => 8.w;
  static double get spacingMd => 12.w;
  static double get spacingLg => 16.w;
  static double get spacingXl => 20.w;
  static double get spacing2xl => 24.w;
  static double get spacing3xl => 32.w;

  // Button
  static double get buttonHeight => 50.h;

  // Nav bar
  static double get navBarHeight => 74.h;
  static double get navIconSize => 20.w;
  static double get navPillHorizontalPadding => 16.w;
  static double get navPillVerticalPadding => 8.h;
  static double get navPillRadius => 20.r;
  static double get navItemRadius => 12.r;

  // Nav text math
  static double get navLabelFontSize => 11.sp;
  static double get navLabelLineHeight => 1.2;
  static double get navLabelGap => 4.h;
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
}
