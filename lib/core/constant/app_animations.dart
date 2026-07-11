import 'dart:ui';

import 'package:flutter/material.dart';

abstract final class AppAnimations {
  static const Duration navDuration = Duration(milliseconds: 280);
  static const Duration contentDuration = Duration(milliseconds: 300);
  static const Duration contentReverseDuration = Duration(milliseconds: 220);
  static const Duration sheetDuration = Duration(milliseconds: 300);
  static const Duration pageRouteDuration = navDuration;
  static const Duration pageRouteReverseDuration = contentReverseDuration;

  static const Curve standardCurve = Curves.easeOutCubic;
  static const Curve exitCurve = Curves.easeInCubic;
  static const Curve backdropCurve = Curves.easeOut;

  static const double navSelectedScale = 1.06;
  static const double expandChevronTurns = 0.5;
  static const double contentSlideOffset = 0.03;
  static const double dateContentSlideOffset = 0.08;
  static const double titleSlideOffset = 0.25;
  static const double pageRouteSlideOffset = 1;
  static const double backdropBlurSigma = 2;
  static const double backdropOverlayOpacity = 0.3;
  static const double appBarBlurSigma = 20;
  static const double appBarGlassOpacity = 0.45;

  /// Fades in a blurred, dimmed backdrop. Stays fixed while sheet content slides.
  static Widget blurredBackdrop({
    required Animation<double> animation,
    required VoidCallback onDismiss,
    double blurSigma = backdropBlurSigma,
    double overlayOpacity = backdropOverlayOpacity,
  }) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: backdropCurve),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onDismiss,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            color: Colors.black.withValues(alpha: overlayOpacity),
          ),
        ),
      ),
    );
  }

  /// Slides content in from the bottom (e.g. bottom sheets).
  static Widget bottomSheetEntrance({
    required Animation<double> animation,
    required Widget child,
    Alignment alignment = Alignment.bottomCenter,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: standardCurve)),
      child: Align(alignment: alignment, child: child),
    );
  }

  /// Blurred backdrop with foreground content that slides up independently.
  static Widget blurredOverlay({
    required Animation<double> animation,
    required Widget child,
    required VoidCallback onDismiss,
    Alignment alignment = Alignment.bottomCenter,
    double blurSigma = backdropBlurSigma,
    double overlayOpacity = backdropOverlayOpacity,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        blurredBackdrop(
          animation: animation,
          onDismiss: onDismiss,
          blurSigma: blurSigma,
          overlayOpacity: overlayOpacity,
        ),
        bottomSheetEntrance(
          animation: animation,
          alignment: alignment,
          child: child,
        ),
      ],
    );
  }

  /// Shows a bottom sheet with a fixed blurred background.
  static Future<T?> showBlurredBottomSheet<T>(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
    String barrierLabel = 'Dismiss',
    Duration transitionDuration = sheetDuration,
    Alignment alignment = Alignment.bottomCenter,
    double blurSigma = backdropBlurSigma,
    double overlayOpacity = backdropOverlayOpacity,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      barrierColor: Colors.transparent,
      transitionDuration: transitionDuration,
      pageBuilder: (context, animation, secondaryAnimation) {
        return blurredOverlay(
          animation: animation,
          alignment: alignment,
          blurSigma: blurSigma,
          overlayOpacity: overlayOpacity,
          onDismiss: () => Navigator.of(context).pop(),
          child: child,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          child,
    );
  }

  /// Stacks outgoing and incoming children for [AnimatedSwitcher].
  static Widget stackedSwitcherLayout(
    Widget? currentChild,
    List<Widget> previousChildren,
  ) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [...previousChildren, ?currentChild],
    );
  }

  /// Slide + fade transition for full-screen page routes.
  static Widget pageSlideTransition({
    required Animation<double> animation,
    required Widget child,
    double slideOffset = pageRouteSlideOffset,
  }) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: standardCurve,
      reverseCurve: exitCurve,
    );

    final slideAnimation = Tween<Offset>(
      begin: Offset(slideOffset, 0),
      end: Offset.zero,
    ).animate(curved);

    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(opacity: curved, child: child),
    );
  }

  /// Fade transition for full-screen page routes.
  static Widget pageFadeTransition({
    required Animation<double> animation,
    required Widget child,
  }) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: standardCurve,
      reverseCurve: exitCurve,
    );

    return FadeTransition(opacity: curved, child: child);
  }

  /// Slide + fade transition for content that changes directionally (e.g. date nav).
  static Widget slideFadeTransition({
    required Widget child,
    required Animation<double> animation,
    required int direction,
    double slideOffset = dateContentSlideOffset,
  }) {
    final slideAnimation =
        Tween<Offset>(
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
      child: KeyedSubtree(key: ValueKey(switchKey), child: child),
    );
  }

  /// Expands/collapses content with a shared height animation (e.g. dropdown lists).
  static Widget expandCollapse({
    required bool isExpanded,
    required Widget child,
    Widget collapsedChild = const SizedBox.shrink(),
    Duration duration = contentDuration,
    Duration reverseDuration = contentReverseDuration,
    Curve curve = standardCurve,
    Alignment alignment = Alignment.topCenter,
  }) {
    return AnimatedSize(
      duration: duration,
      reverseDuration: reverseDuration,
      curve: curve,
      alignment: alignment,
      clipBehavior: Clip.hardEdge,
      child: isExpanded ? child : collapsedChild,
    );
  }

  /// Rotates a chevron for expand/collapse affordances.
  static Widget expandChevron({
    required bool isExpanded,
    required Widget child,
    Duration duration = contentDuration,
    Curve curve = standardCurve,
    double turns = expandChevronTurns,
  }) {
    return AnimatedRotation(
      turns: isExpanded ? turns : 0,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}
