import 'app_screen.dart';

extension ResponsiveSize on num {
  /// Responsive width
  double get w => AppScreen.setWidth(this);

  /// Responsive height
  double get h => AppScreen.setHeight(this);

  /// Responsive font size (sp)
  double get sp => AppScreen.setSp(this);

  /// Responsive radius (r)
  double get r => AppScreen.setRadius(this);
}
