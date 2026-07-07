abstract final class AppDimensions {
  // Page layout
  static const double pagePadding = 24;
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 12;
  static const double spacingLg = 16;
  static const double spacingXl = 20;
  static const double spacing2xl = 24;
  static const double spacing3xl = 32;

  // Nav bar
  static const double navBarHeight = 74;
  static const double navIconSize = 20;
  static const double navPillHorizontalPadding = 16;
  static const double navPillVerticalPadding = 8;
  static const double navPillRadius = 20;
  static const double navItemRadius = 12;
  static const double navLabelFontSize = 11;
  static const double navLabelLineHeight = 1.2;
  static const double navLabelGap = 4;
  static const double navLabelHeight = navLabelFontSize * navLabelLineHeight;

  static const double navPillHeight = navIconSize + navPillVerticalPadding * 2;
  static const double navPillWidth = navIconSize + navPillHorizontalPadding * 2;
  static const double navContentHeight =
      navPillHeight + navLabelGap + navLabelHeight;

  // Radius
  static const double radiusSm = 9;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
}
