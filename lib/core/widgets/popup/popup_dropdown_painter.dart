import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:flutter/material.dart';

import 'popup_arrow_side.dart';

/// Paints the popup dropdown style using the app theme surfaces.
class PopupDropdownStylePainter extends CustomPainter {
  PopupDropdownStylePainter({
    required this.theme,
    required this.arrowSide,
    this.arrowOffset = 0.5,
    this.arrowColor,
  });

  final AppThemeExtension theme;
  final PopupArrowSide arrowSide;
  final double arrowOffset;
  final Color? arrowColor;

  static const double _borderRadius = 8.0;
  static const double _triangleHeight = 12.0;
  static const double _triangleWidth = 20.0;
  static const double _inset = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);
    final bodyPath = _buildBodyOnlyPath(size);

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.save();
    canvas.translate(0, 2);
    canvas.drawPath(bodyPath, shadowPaint);
    canvas.restore();

    canvas.drawPath(
      path,
      Paint()
        ..color = theme.backgroundPage
        ..style = PaintingStyle.fill,
    );

    if (arrowColor != null) {
      canvas.drawPath(
        _buildArrowOnlyPath(size),
        Paint()
          ..color = arrowColor!
          ..style = PaintingStyle.fill,
      );
    }
  }

  Path _buildPath(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    final length =
        arrowSide == PopupArrowSide.top || arrowSide == PopupArrowSide.bottom
            ? w
            : h;
    final triCenter = _inset +
        (length - _inset * 2 - _triangleWidth).clamp(0.0, double.infinity) *
            arrowOffset.clamp(0.0, 1.0);
    final triLeft = triCenter - _triangleWidth / 2;
    final triRight = triCenter + _triangleWidth / 2;

    switch (arrowSide) {
      case PopupArrowSide.top:
        _pathWithTopNotch(path, w, h, triLeft, triRight);
      case PopupArrowSide.bottom:
        _pathWithBottomNotch(path, w, h, triLeft, triRight);
      case PopupArrowSide.left:
        _pathWithLeftNotch(path, w, h, triLeft, triRight);
      case PopupArrowSide.right:
        _pathWithRightNotch(path, w, h, triLeft, triRight);
    }
    path.close();
    return path;
  }

  Path _buildArrowOnlyPath(Size size) {
    final w = size.width;
    final h = size.height;
    final length =
        arrowSide == PopupArrowSide.top || arrowSide == PopupArrowSide.bottom
            ? w
            : h;
    final triCenter = _inset +
        (length - _inset * 2 - _triangleWidth).clamp(0.0, double.infinity) *
            arrowOffset.clamp(0.0, 1.0);
    final triLeft = triCenter - _triangleWidth / 2;
    final triRight = triCenter + _triangleWidth / 2;
    final path = Path();

    switch (arrowSide) {
      case PopupArrowSide.top:
        path.moveTo(triLeft + _triangleWidth / 2, 0);
        path.lineTo(
          triRight.clamp(_borderRadius, w - _borderRadius),
          _triangleHeight,
        );
        path.lineTo(
          triLeft.clamp(_borderRadius, w - _borderRadius),
          _triangleHeight,
        );
      case PopupArrowSide.bottom:
        final bodyH = h - _triangleHeight;
        path.moveTo(triLeft + _triangleWidth / 2, h);
        path.lineTo(triLeft.clamp(_borderRadius, w - _borderRadius), bodyH);
        path.lineTo(triRight.clamp(_borderRadius, w - _borderRadius), bodyH);
      case PopupArrowSide.left:
        path.moveTo(0, triLeft + _triangleWidth / 2);
        path.lineTo(
          _triangleHeight,
          triRight.clamp(_borderRadius, h - _borderRadius),
        );
        path.lineTo(
          _triangleHeight,
          triLeft.clamp(_borderRadius, h - _borderRadius),
        );
      case PopupArrowSide.right:
        final bodyW = w - _triangleHeight;
        path.moveTo(w, triLeft + _triangleWidth / 2);
        path.lineTo(bodyW, triRight.clamp(_borderRadius, h - _borderRadius));
        path.lineTo(bodyW, triLeft.clamp(_borderRadius, h - _borderRadius));
    }
    path.close();
    return path;
  }

  Path _buildBodyOnlyPath(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    switch (arrowSide) {
      case PopupArrowSide.top:
        path.addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, _triangleHeight, w, h - _triangleHeight),
            const Radius.circular(_borderRadius),
          ),
        );
      case PopupArrowSide.bottom:
        path.addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, w, h - _triangleHeight),
            const Radius.circular(_borderRadius),
          ),
        );
      case PopupArrowSide.left:
        path.addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(_triangleHeight, 0, w - _triangleHeight, h),
            const Radius.circular(_borderRadius),
          ),
        );
      case PopupArrowSide.right:
        path.addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, w - _triangleHeight, h),
            const Radius.circular(_borderRadius),
          ),
        );
    }
    return path;
  }

  void _pathWithTopNotch(
    Path path,
    double w,
    double h,
    double triLeft,
    double triRight,
  ) {
    final bodyH = h - _triangleHeight;
    path.moveTo(_borderRadius, _triangleHeight);
    path.lineTo(
      triLeft.clamp(_borderRadius, w - _borderRadius),
      _triangleHeight,
    );
    path.lineTo(triLeft + _triangleWidth / 2, 0);
    path.lineTo(
      triRight.clamp(_borderRadius, w - _borderRadius),
      _triangleHeight,
    );
    path.lineTo(w - _borderRadius, _triangleHeight);
    path.quadraticBezierTo(
      w,
      _triangleHeight,
      w,
      _triangleHeight + _borderRadius,
    );
    path.lineTo(w, bodyH - _borderRadius);
    path.quadraticBezierTo(w, bodyH, w - _borderRadius, bodyH);
    path.lineTo(_borderRadius, bodyH);
    path.quadraticBezierTo(0, bodyH, 0, bodyH - _borderRadius);
    path.lineTo(0, _triangleHeight + _borderRadius);
    path.quadraticBezierTo(0, _triangleHeight, _borderRadius, _triangleHeight);
  }

  void _pathWithBottomNotch(
    Path path,
    double w,
    double h,
    double triLeft,
    double triRight,
  ) {
    final bodyH = h - _triangleHeight;
    path.moveTo(_borderRadius, 0);
    path.lineTo(w - _borderRadius, 0);
    path.quadraticBezierTo(w, 0, w, _borderRadius);
    path.lineTo(w, bodyH - _borderRadius);
    path.quadraticBezierTo(w, bodyH, w - _borderRadius, bodyH);
    path.lineTo(triRight.clamp(_borderRadius, w - _borderRadius), bodyH);
    path.lineTo(triLeft + _triangleWidth / 2, h);
    path.lineTo(triLeft.clamp(_borderRadius, w - _borderRadius), bodyH);
    path.lineTo(_borderRadius, bodyH);
    path.quadraticBezierTo(0, bodyH, 0, bodyH - _borderRadius);
    path.lineTo(0, _borderRadius);
    path.quadraticBezierTo(0, 0, _borderRadius, 0);
  }

  void _pathWithLeftNotch(
    Path path,
    double w,
    double h,
    double triLeft,
    double triRight,
  ) {
    final bodyW = w - _triangleHeight;
    path.moveTo(_triangleHeight, _borderRadius);
    path.lineTo(
      _triangleHeight,
      triLeft.clamp(_borderRadius, h - _borderRadius),
    );
    path.lineTo(0, triLeft + _triangleWidth / 2);
    path.lineTo(
      _triangleHeight,
      triRight.clamp(_borderRadius, h - _borderRadius),
    );
    path.lineTo(_triangleHeight, h - _borderRadius);
    path.quadraticBezierTo(
      _triangleHeight,
      h,
      _triangleHeight + _borderRadius,
      h,
    );
    path.lineTo(bodyW - _borderRadius, h);
    path.quadraticBezierTo(bodyW, h, bodyW, h - _borderRadius);
    path.lineTo(bodyW, _borderRadius);
    path.quadraticBezierTo(bodyW, 0, bodyW - _borderRadius, 0);
    path.lineTo(_triangleHeight + _borderRadius, 0);
    path.quadraticBezierTo(_triangleHeight, 0, _triangleHeight, _borderRadius);
  }

  void _pathWithRightNotch(
    Path path,
    double w,
    double h,
    double triLeft,
    double triRight,
  ) {
    final bodyW = w - _triangleHeight;
    path.moveTo(0, _borderRadius);
    path.lineTo(bodyW - _borderRadius, 0);
    path.quadraticBezierTo(bodyW, 0, bodyW, _borderRadius);
    path.lineTo(bodyW, triLeft.clamp(_borderRadius, h - _borderRadius));
    path.lineTo(w, triLeft + _triangleWidth / 2);
    path.lineTo(bodyW, triRight.clamp(_borderRadius, h - _borderRadius));
    path.lineTo(bodyW, h - _borderRadius);
    path.quadraticBezierTo(bodyW, h, bodyW - _borderRadius, h);
    path.lineTo(_triangleHeight + _borderRadius, h);
    path.quadraticBezierTo(
      _triangleHeight,
      h,
      _triangleHeight,
      h - _borderRadius,
    );
    path.lineTo(_triangleHeight, _borderRadius);
    path.quadraticBezierTo(
      _triangleHeight,
      0,
      _triangleHeight + _borderRadius,
      0,
    );
  }

  @override
  bool shouldRepaint(covariant PopupDropdownStylePainter old) =>
      old.arrowSide != arrowSide ||
      old.arrowOffset != arrowOffset ||
      old.theme != theme ||
      old.arrowColor != arrowColor;
}
