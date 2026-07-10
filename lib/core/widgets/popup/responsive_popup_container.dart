import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:flutter/material.dart';

import 'popup_arrow_side.dart';
import 'popup_dropdown_painter.dart';

export 'popup_arrow_side.dart' show PopupArrowSide;

enum PopupStyle { card, dropdown }

class ResponsivePopupContainer extends StatelessWidget {
  const ResponsivePopupContainer({
    super.key,
    required this.child,
    this.width = 180,
    this.arrowSide,
    this.arrowOffset = 0.5,
    this.arrowColor,
    this.style = PopupStyle.card,
  });

  final Widget child;
  final double width;
  final PopupArrowSide? arrowSide;
  final double arrowOffset;
  final Color? arrowColor;
  final PopupStyle style;

  static const double _arrowSize = 10;
  static const double _dropdownArrowHeight = 12;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final hasArrow = arrowSide != null;

    if (style == PopupStyle.dropdown && hasArrow) {
      return Material(
        color: Colors.transparent,
        child: _buildDropdownStyle(theme),
      );
    }

    return Material(
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (hasArrow) _buildArrowShadow(theme),
          Container(
            width: width,
            decoration: BoxDecoration(
              color: theme.backgroundPage,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              border: Border.all(color: theme.borderDefault),
              boxShadow: theme.cardShadow,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              child: child,
            ),
          ),
          if (hasArrow) _buildArrow(theme),
        ],
      ),
    );
  }

  Widget _buildDropdownStyle(AppThemeExtension theme) {
    EdgeInsets padding = EdgeInsets.zero;
    switch (arrowSide!) {
      case PopupArrowSide.top:
        padding = const EdgeInsets.only(top: _dropdownArrowHeight);
        break;
      case PopupArrowSide.bottom:
        padding = const EdgeInsets.only(bottom: _dropdownArrowHeight);
        break;
      case PopupArrowSide.left:
        padding = const EdgeInsets.only(left: _dropdownArrowHeight);
        break;
      case PopupArrowSide.right:
        padding = const EdgeInsets.only(right: _dropdownArrowHeight);
        break;
    }

    return CustomPaint(
      painter: PopupDropdownStylePainter(
        theme: theme,
        arrowSide: arrowSide!,
        arrowOffset: arrowOffset,
        arrowColor: arrowColor,
      ),
      child: Padding(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          child: SizedBox(
            width: width - padding.left - padding.right,
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildArrowShadow(AppThemeExtension theme) {
    final color = arrowColor ?? theme.backgroundPage;
    const strip = _arrowSize * 2.0;

    return _positionArrowStrip(
      strip: strip,
      painter: _PopupArrowPainter(
        side: arrowSide!,
        offset: arrowOffset,
        color: color,
        shadowColor: Colors.black26,
        shadowOnly: true,
      ),
    );
  }

  Widget _buildArrow(AppThemeExtension theme) {
    final color = arrowColor ?? theme.backgroundPage;
    const strip = _arrowSize * 2.0;

    return _positionArrowStrip(
      strip: strip,
      painter: _PopupArrowPainter(
        side: arrowSide!,
        offset: arrowOffset,
        color: color,
        shadowColor: Colors.black26,
        shadowOnly: false,
      ),
    );
  }

  Widget _positionArrowStrip({
    required double strip,
    required _PopupArrowPainter painter,
  }) {
    switch (arrowSide!) {
      case PopupArrowSide.bottom:
        return Positioned(
          left: 0,
          right: 0,
          bottom: -_arrowSize,
          height: strip,
          child: CustomPaint(size: Size(width, strip), painter: painter),
        );
      case PopupArrowSide.top:
        return Positioned(
          left: 0,
          right: 0,
          top: -_arrowSize,
          height: strip,
          child: CustomPaint(size: Size(width, strip), painter: painter),
        );
      case PopupArrowSide.right:
        return Positioned(
          top: 0,
          bottom: 0,
          right: -_arrowSize,
          width: strip,
          child: CustomPaint(size: Size(strip, width), painter: painter),
        );
      case PopupArrowSide.left:
        return Positioned(
          top: 0,
          bottom: 0,
          left: -_arrowSize,
          width: strip,
          child: CustomPaint(size: Size(strip, width), painter: painter),
        );
    }
  }
}

class _PopupArrowPainter extends CustomPainter {
  const _PopupArrowPainter({
    required this.side,
    required this.offset,
    required this.color,
    required this.shadowColor,
    this.shadowOnly = false,
  });

  final PopupArrowSide side;
  final double offset;
  final Color color;
  final Color shadowColor;
  final bool shadowOnly;

  static const double _arrowSize = 10;
  static const double _inset = 12;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = _inset +
        (size.width - _inset * 2 - _arrowSize * 2).clamp(0.0, double.infinity) *
            offset;
    final centerY = _inset +
        (size.height - _inset * 2 - _arrowSize * 2)
                .clamp(0.0, double.infinity) *
            offset;

    late final Offset tip;
    late final List<Offset> triangle;

    switch (side) {
      case PopupArrowSide.bottom:
        tip = Offset(centerX + _arrowSize, size.height);
        triangle = [
          tip,
          Offset(tip.dx - _arrowSize, tip.dy - _arrowSize),
          Offset(tip.dx + _arrowSize, tip.dy - _arrowSize),
        ];
      case PopupArrowSide.top:
        tip = Offset(centerX + _arrowSize, 0);
        triangle = [
          tip,
          Offset(tip.dx - _arrowSize, tip.dy + _arrowSize),
          Offset(tip.dx + _arrowSize, tip.dy + _arrowSize),
        ];
      case PopupArrowSide.right:
        tip = Offset(size.width, centerY + _arrowSize);
        triangle = [
          tip,
          Offset(tip.dx - _arrowSize, tip.dy - _arrowSize),
          Offset(tip.dx - _arrowSize, tip.dy + _arrowSize),
        ];
      case PopupArrowSide.left:
        tip = Offset(0, centerY + _arrowSize);
        triangle = [
          tip,
          Offset(tip.dx + _arrowSize, tip.dy - _arrowSize),
          Offset(tip.dx + _arrowSize, tip.dy + _arrowSize),
        ];
    }

    final path = Path()..addPolygon(triangle, true);

    if (shadowOnly) {
      canvas.save();
      canvas.translate(2, 4);
      canvas.drawPath(path, Paint()..color = shadowColor.withValues(alpha: 0.05));
      canvas.restore();
    } else {
      canvas.drawPath(path, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(covariant _PopupArrowPainter old) =>
      old.side != side ||
      old.offset != offset ||
      old.color != color ||
      old.shadowOnly != shadowOnly;
}
