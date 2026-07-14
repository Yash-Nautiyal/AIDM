import 'package:flutter/material.dart';

import '../../constant/app_dimensions.dart';
import '../../theme/app_theme_extension.dart';
import '../../theme/typography/app_typography_extension.dart';
import '../../utils/app/responsive_extension.dart';

class AppInput2 extends StatefulWidget {
  const AppInput2({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = 'Enter your webinar title',
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.showBorder = false,
    this.showShadow = false,
    this.trailing,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool showBorder;
  final bool showShadow;
  final Widget? trailing;

  @override
  State<AppInput2> createState() => _AppInput2State();
}

class _AppInput2State extends State<AppInput2> {
  late final FocusNode _focusNode;
  late final bool _ownsFocusNode;

  @override
  void initState() {
    super.initState();
    _ownsFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant AppInput2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.removeListener(_onFocusChanged);
      if (_ownsFocusNode) {
        _focusNode.dispose();
      }
      _ownsFocusNode = widget.focusNode == null;
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChanged);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final isFocused = _focusNode.hasFocus;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.backgroundPage,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(AppDimensions.radiusSm),
          right: Radius.circular(AppDimensions.radiusSm),
        ),
        border: isFocused
            ? Border.all(color: theme.borderFocus, width: 1)
            : widget.showBorder
            ? Border.all(color: theme.borderDefault, width: 1)
            : null,
        boxShadow: widget.showShadow
            ? const [
                BoxShadow(
                  color: Color(0x0D000000),
                  offset: Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              style: typography.body16.copyWith(color: theme.textPrimary),
              cursorColor: theme.borderFocus,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: typography.body16.copyWith(color: theme.textTertiary),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 11.h,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          if (widget.trailing != null)
            Padding(
              padding: EdgeInsets.only(right: AppDimensions.spacingSm),
              child: widget.trailing!,
            ),
        ],
      ),
    );
  }
}
