import 'package:aidm/core/constant/app_animations.dart';
import 'package:flutter/material.dart';

import 'app_bottom_sheet.dart';

Future<T?> showAppBottomSheet<T>(
  BuildContext context, {
  Widget? header,
  required Widget body,
  Widget? footer,
  bool showHeaderDivider = true,
  bool showFooterDivider = false,
  bool scrollBody = false,
  EdgeInsetsGeometry? padding,
  bool barrierDismissible = true,
  String barrierLabel = 'Dismiss',
  bool showFooterButton = false,
  String? footerButtonLabel,
  VoidCallback? onFooterButtonPressed,
  Duration transitionDuration = AppAnimations.sheetDuration,
  double blurSigma = AppAnimations.backdropBlurSigma,
  double overlayOpacity = AppAnimations.backdropOverlayOpacity,
}) {
  return AppAnimations.showBlurredBottomSheet<T>(
    context,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    transitionDuration: transitionDuration,
    blurSigma: blurSigma,
    overlayOpacity: overlayOpacity,
    child: AppBottomSheet(
      header: header,
      body: body,
      footer: footer,
      showFooterButton: showFooterButton,
      footerButtonLabel: footerButtonLabel,
      onFooterButtonPressed: onFooterButtonPressed,
      showHeaderDivider: showHeaderDivider,
      showFooterDivider: showFooterDivider,
      scrollBody: scrollBody,
      padding: padding,
    ),
  );
}
