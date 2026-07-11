import 'package:flutter/material.dart';

import '../constant/app_animations.dart';

enum AppRouteTransition { slide, fade }

class ShellTab extends StatelessWidget {
  const ShellTab({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) => pageRoute(page: child, settings: settings),
    );
  }
}

Route<T> pageRoute<T>({
  required Widget page,
  RouteSettings? settings,
  AppRouteTransition transition = AppRouteTransition.slide,
  bool fullscreenDialog = false,
  Duration? duration,
  Duration? reverseDuration,
}) {
  return PageRouteBuilder<T>(
    settings: settings,
    fullscreenDialog: fullscreenDialog,
    transitionDuration: duration ?? AppAnimations.pageRouteDuration,
    reverseTransitionDuration:
        reverseDuration ?? AppAnimations.pageRouteReverseDuration,
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (_, animation, _, child) {
      return switch (transition) {
        AppRouteTransition.slide => AppAnimations.pageSlideTransition(
          animation: animation,
          child: child,
        ),
        AppRouteTransition.fade => AppAnimations.pageFadeTransition(
          animation: animation,
          child: child,
        ),
      };
    },
  );
}

Future<T?> moveTo<T>(
  BuildContext context,
  Widget page, {
  AppRouteTransition transition = AppRouteTransition.slide,
  bool replace = false,
  bool clearStack = false,
  RouteSettings? settings,
}) {
  final route = pageRoute<T>(
    page: page,
    settings: settings,
    transition: transition,
  );

  final navigator = Navigator.of(context, rootNavigator: clearStack);

  if (clearStack) {
    return navigator.pushAndRemoveUntil<T>(route, (_) => false);
  }
  if (replace) {
    return navigator.pushReplacement<T, Object?>(route);
  }
  return navigator.push<T>(route);
}

void moveBack<T extends Object?>(BuildContext context, [T? result]) {
  Navigator.of(context).pop<T>(result);
}

Future<bool> maybeMoveBack<T extends Object?>(
  BuildContext context, [
  T? result,
]) {
  return Navigator.of(context).maybePop<T>(result);
}
