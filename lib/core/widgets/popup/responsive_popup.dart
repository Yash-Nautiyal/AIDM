import 'package:flutter/material.dart';

import 'popup_arrow_side.dart';
import 'responsive_popup_container.dart';

/// Preferred side to open the popup relative to the anchor.
enum PopupPreferredPosition { left, right, top, bottom, auto }

/// Cross-axis alignment of the popup relative to the anchor.
enum PopupCrossAxisAlignment { start, center, end }

/// Placement for the popup when using [ResponsivePopupController.show].
class PopupPlacement {
  const PopupPlacement({
    required this.targetAnchor,
    required this.followerAnchor,
    required this.offset,
    this.arrowSide,
    this.arrowOffset = 0.5,
  });

  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Offset offset;
  final PopupArrowSide? arrowSide;
  final double arrowOffset;
}

class ResponsivePopupController {
  OverlayEntry? _entry;
  void Function()? _exitAnimationCallback;

  bool get isShowing => _entry != null;

  void removeEntry() {
    _entry?.remove();
    _entry = null;
    _exitAnimationCallback = null;
  }

  void registerExit(void Function() animateOut) {
    _exitAnimationCallback = animateOut;
  }

  static const double _gap = 8;

  void show({
    required BuildContext context,
    required LayerLink link,
    Widget? child,
    Widget Function(PopupPlacement placement)? childBuilder,
    PopupPreferredPosition preferredPosition = PopupPreferredPosition.auto,
    PopupCrossAxisAlignment crossAxisAlignment = PopupCrossAxisAlignment.end,
    Offset manualOffset = Offset.zero,
    double? popupWidth,
    bool showArrow = false,
    GlobalKey? anchorKey,
  }) {
    hide();

    final placement = _resolvePlacement(
      context: context,
      anchorKey: anchorKey,
      preferredPosition: preferredPosition,
      crossAxisAlignment: crossAxisAlignment,
      manualOffset: manualOffset,
      showArrow: showArrow,
    );

    final finalChild = childBuilder != null
        ? childBuilder(placement)
        : child ?? const SizedBox.shrink();

    _entry = OverlayEntry(
      builder: (_) => _AnimatedPopupOverlay(
        controller: this,
        link: link,
        placement: placement,
        child: finalChild,
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_entry!);
  }

  PopupPlacement _resolvePlacement({
    required BuildContext context,
    GlobalKey? anchorKey,
    required PopupPreferredPosition preferredPosition,
    required PopupCrossAxisAlignment crossAxisAlignment,
    required Offset manualOffset,
    required bool showArrow,
  }) {
    final resolvedPosition = _resolvePreferredPosition(
      context: context,
      anchorKey: anchorKey,
      preferredPosition: preferredPosition,
    );

    final anchors = _anchorsFor(
      position: resolvedPosition,
      crossAxisAlignment: crossAxisAlignment,
    );

    final arrowSide = showArrow ? _arrowSideForPosition(resolvedPosition) : null;
    final arrowOffset = _arrowOffsetFor(
      crossAxisAlignment: crossAxisAlignment,
      arrowSide: arrowSide,
    );

    return PopupPlacement(
      targetAnchor: anchors.target,
      followerAnchor: anchors.follower,
      offset: manualOffset + _offsetFor(resolvedPosition),
      arrowSide: arrowSide,
      arrowOffset: arrowOffset,
    );
  }

  PopupPreferredPosition _resolvePreferredPosition({
    required BuildContext context,
    GlobalKey? anchorKey,
    required PopupPreferredPosition preferredPosition,
  }) {
    if (preferredPosition != PopupPreferredPosition.auto || anchorKey == null) {
      return preferredPosition == PopupPreferredPosition.auto
          ? PopupPreferredPosition.bottom
          : preferredPosition;
    }

    final anchorBox =
        anchorKey.currentContext?.findRenderObject() as RenderBox?;
    if (anchorBox == null || !anchorBox.hasSize) {
      return PopupPreferredPosition.bottom;
    }

    final screenSize = MediaQuery.sizeOf(context);
    final anchorPos = anchorBox.localToGlobal(Offset.zero);
    final anchorSize = anchorBox.size;

    final spaceAbove = anchorPos.dy;
    final spaceBelow = screenSize.height - (anchorPos.dy + anchorSize.height);
    final spaceLeft = anchorPos.dx;
    final spaceRight = screenSize.width - (anchorPos.dx + anchorSize.width);

    final scores = <PopupPreferredPosition, double>{
      PopupPreferredPosition.top: spaceAbove,
      PopupPreferredPosition.bottom: spaceBelow,
      PopupPreferredPosition.left: spaceLeft,
      PopupPreferredPosition.right: spaceRight,
    };

    return scores.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  ({Alignment target, Alignment follower}) _anchorsFor({
    required PopupPreferredPosition position,
    required PopupCrossAxisAlignment crossAxisAlignment,
  }) {
    final horizontal = switch (crossAxisAlignment) {
      PopupCrossAxisAlignment.start => (
          targetX: -1.0,
          followerX: -1.0,
        ),
      PopupCrossAxisAlignment.center => (
          targetX: 0.0,
          followerX: 0.0,
        ),
      PopupCrossAxisAlignment.end => (
          targetX: 1.0,
          followerX: 1.0,
        ),
    };

    return switch (position) {
      PopupPreferredPosition.top => (
          target: Alignment(horizontal.targetX, -1),
          follower: Alignment(horizontal.followerX, 1),
        ),
      PopupPreferredPosition.bottom => (
          target: Alignment(horizontal.targetX, 1),
          follower: Alignment(horizontal.followerX, -1),
        ),
      PopupPreferredPosition.left => (
          target: Alignment(-1, horizontal.targetX),
          follower: Alignment(1, horizontal.followerX),
        ),
      PopupPreferredPosition.right => (
          target: Alignment(1, horizontal.targetX),
          follower: Alignment(-1, horizontal.followerX),
        ),
      PopupPreferredPosition.auto => (
          target: Alignment(horizontal.targetX, 1),
          follower: Alignment(horizontal.followerX, -1),
        ),
    };
  }

  Offset _offsetFor(PopupPreferredPosition position) {
    return switch (position) {
      PopupPreferredPosition.top => Offset(0, -_gap),
      PopupPreferredPosition.bottom => Offset(0, _gap),
      PopupPreferredPosition.left => Offset(-_gap, 0),
      PopupPreferredPosition.right => Offset(_gap, 0),
      PopupPreferredPosition.auto => Offset(0, _gap),
    };
  }

  PopupArrowSide? _arrowSideForPosition(PopupPreferredPosition position) {
    return switch (position) {
      PopupPreferredPosition.top => PopupArrowSide.bottom,
      PopupPreferredPosition.bottom => PopupArrowSide.top,
      PopupPreferredPosition.left => PopupArrowSide.right,
      PopupPreferredPosition.right => PopupArrowSide.left,
      PopupPreferredPosition.auto => PopupArrowSide.top,
    };
  }

  double _arrowOffsetFor({
    required PopupCrossAxisAlignment crossAxisAlignment,
    PopupArrowSide? arrowSide,
  }) {
    if (arrowSide == null) return 0.5;

    return switch (crossAxisAlignment) {
      PopupCrossAxisAlignment.start => 0.15,
      PopupCrossAxisAlignment.center => 0.5,
      PopupCrossAxisAlignment.end => 0.85,
    };
  }

  void hide() {
    if (_exitAnimationCallback != null) {
      _exitAnimationCallback!();
      _exitAnimationCallback = null;
    } else {
      removeEntry();
    }
  }

  void dispose() {
    hide();
  }
}

class _AnimatedPopupOverlay extends StatefulWidget {
  const _AnimatedPopupOverlay({
    required this.controller,
    required this.link,
    required this.placement,
    required this.child,
  });

  final ResponsivePopupController controller;
  final LayerLink link;
  final PopupPlacement placement;
  final Widget child;

  @override
  State<_AnimatedPopupOverlay> createState() => _AnimatedPopupOverlayState();
}

class _AnimatedPopupOverlayState extends State<_AnimatedPopupOverlay>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 200);
  static const double _slideDistance = 10;

  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _slide = Tween<Offset>(
      begin: _slideBeginForPlacement(widget.placement),
      end: Offset.zero,
    ).animate(curve);
    _opacity = Tween<double>(begin: 0, end: 1).animate(curve);
    widget.controller.registerExit(_animateOut);
    _controller.forward();
  }

  static Offset _slideBeginForPlacement(PopupPlacement placement) {
    if (placement.targetAnchor.y > 0) {
      return const Offset(0, _slideDistance);
    }
    if (placement.targetAnchor.y < 0) {
      return const Offset(0, -_slideDistance);
    }
    if (placement.targetAnchor.x > 0) {
      return const Offset(_slideDistance, 0);
    }
    if (placement.targetAnchor.x < 0) {
      return const Offset(-_slideDistance, 0);
    }
    return const Offset(0, _slideDistance);
  }

  void _animateOut() {
    if (!_controller.isAnimating && _controller.value > 0) {
      _controller.reverse().then((_) {
        if (mounted) widget.controller.removeEntry();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _animateOut,
        child: Stack(
          children: [
            CompositedTransformFollower(
              link: widget.link,
              targetAnchor: widget.placement.targetAnchor,
              followerAnchor: widget.placement.followerAnchor,
              offset: widget.placement.offset,
              showWhenUnlinked: false,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacity.value,
                    child: Transform.translate(
                      offset: _slide.value,
                      child: child,
                    ),
                  );
                },
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
