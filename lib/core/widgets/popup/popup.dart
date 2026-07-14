import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:aidm/core/widgets/popup/responsive_popup.dart';
import 'package:aidm/core/widgets/popup/responsive_popup_container.dart';
import 'package:flutter/material.dart';

class AppPopup extends StatefulWidget {
  const AppPopup({
    super.key,
    required this.popupAnchorKey,
    required this.layerLink,
    required this.popupController,
    required this.trigger,
    required this.items,
    this.preferredPosition = PopupPreferredPosition.bottom,
    this.crossAxisAlignment = PopupCrossAxisAlignment.end,
    this.manualOffset = Offset.zero,
    this.width = 200,
    this.showArrow = false,
    this.arrowColor,
  });

  final GlobalKey popupAnchorKey;
  final LayerLink layerLink;
  final ResponsivePopupController popupController;
  final Widget trigger;
  final List<Widget> items;
  final PopupPreferredPosition preferredPosition;
  final PopupCrossAxisAlignment crossAxisAlignment;
  final Offset manualOffset;
  final double width;
  final bool showArrow;
  final Color? arrowColor;

  @override
  State<AppPopup> createState() => _AppPopupState();
}

class _AppPopupState extends State<AppPopup> {
  void _togglePopup() {
    if (widget.popupController.isShowing) {
      widget.popupController.hide();
      return;
    }

    widget.popupController.show(
      context: context,
      link: widget.layerLink,
      anchorKey: widget.popupAnchorKey,
      preferredPosition: widget.preferredPosition,
      crossAxisAlignment: widget.crossAxisAlignment,
      manualOffset: widget.manualOffset,
      popupWidth: widget.width,
      showArrow: widget.showArrow,
      childBuilder: (placement) => ResponsivePopupContainer(
        width: widget.width,
        arrowSide: placement.arrowSide,
        arrowOffset: placement.arrowOffset,
        arrowColor: widget.arrowColor,
        child: Column(mainAxisSize: MainAxisSize.min, children: widget.items),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      key: widget.popupAnchorKey,
      link: widget.layerLink,
      child: GestureDetector(
        onTap: _togglePopup,
        behavior: HitTestBehavior.opaque,
        child: widget.trigger,
      ),
    );
  }
}

/// Default popup width for action menus.
double get appPopupMenuWidth => 160.sp;
