import 'package:flutter/material.dart';

abstract final class AppAnimations {
  static const Duration navDuration = Duration(milliseconds: 280);
  static const Duration contentDuration = Duration(milliseconds: 300);

  static const Curve standardCurve = Curves.easeOutCubic;
  static const Curve exitCurve = Curves.easeInCubic;

  static const double navSelectedScale = 1.06;
  static const double contentSlideOffset = 0.03;
  static const double dateContentSlideOffset = 0.08;
  static const double titleSlideOffset = 0.25;

  /// Stacks outgoing and incoming children for [AnimatedSwitcher].
  static Widget stackedSwitcherLayout(
    Widget? currentChild,
    List<Widget> previousChildren,
  ) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        ...previousChildren,
        ?currentChild,
      ],
    );
  }

  /// Slide + fade transition for content that changes directionally (e.g. date nav).
  static Widget slideFadeTransition({
    required Widget child,
    required Animation<double> animation,
    required int direction,
    double slideOffset = dateContentSlideOffset,
  }) {
    final slideAnimation = Tween<Offset>(
      begin: Offset(direction * slideOffset, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: standardCurve,
        reverseCurve: exitCurve,
      ),
    );

    final fadeAnimation = CurvedAnimation(
      parent: animation,
      curve: standardCurve,
      reverseCurve: exitCurve,
    );

    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(opacity: fadeAnimation, child: child),
    );
  }

  /// Common [AnimatedSwitcher] for directional content changes.
  static Widget contentSwitcher({
    required Object switchKey,
    required int direction,
    required Widget child,
    Duration duration = contentDuration,
    double slideOffset = dateContentSlideOffset,
  }) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: standardCurve,
      switchOutCurve: exitCurve,
      layoutBuilder: stackedSwitcherLayout,
      transitionBuilder: (switcherChild, animation) => slideFadeTransition(
        child: switcherChild,
        animation: animation,
        direction: direction,
        slideOffset: slideOffset,
      ),
      child: KeyedSubtree(
        key: ValueKey(switchKey),
        child: child,
      ),
    );
  }
}
