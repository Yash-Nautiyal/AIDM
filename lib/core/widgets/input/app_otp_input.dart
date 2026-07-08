import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppOtpInput extends StatefulWidget {
  const AppOtpInput({
    super.key,
    this.length = 6,
    this.onChanged,
    this.onCompleted,
    this.autofocus = true,
  });

  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool autofocus;

  @override
  State<AppOtpInput> createState() => AppOtpInputState();
}

class AppOtpInputState extends State<AppOtpInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  String get value => _controller.text;

  void clear() {
    _controller.clear();
    widget.onChanged?.call('');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleTextChanged);
    _focusNode.addListener(_handleFocusChanged);
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    _focusNode.removeListener(_handleFocusChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    final text = _controller.text;
    widget.onChanged?.call(text);
    if (text.length == widget.length) {
      widget.onCompleted?.call(text);
    }
    setState(() {});
  }

  void _handleFocusChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0,
            child: SizedBox(
              height: AppDimensions.otpBoxHeight,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                maxLength: widget.length,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.length, (index) {
              final hasValue = index < _controller.text.length;
              final isFocused =
                  _focusNode.hasFocus && index == _controller.text.length;
              final showBorder = hasValue || isFocused;
              final digit = hasValue ? _controller.text[index] : '';

              return Padding(
                padding: EdgeInsets.only(
                  right: index == widget.length - 1
                      ? 0
                      : AppDimensions.otpBoxGap,
                ),
                child: _OtpBox(
                  hasValue: hasValue,
                  isFocused: isFocused,
                  showBorder: showBorder,
                  digit: digit,
                  isDark: isDark,
                  theme: theme,
                  typography: typography,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.hasValue,
    required this.isFocused,
    required this.showBorder,
    required this.digit,
    required this.isDark,
    required this.theme,
    required this.typography,
  });

  final bool hasValue;
  final bool isFocused;
  final bool showBorder;
  final String digit;
  final bool isDark;
  final AppThemeExtension theme;
  final AppTypographyExtension typography;

  Color get _backgroundColor {
    if (hasValue || isFocused) {
      return isDark ? theme.backgroundInput : theme.backgroundPage;
    }
    return theme.backgroundInput;
  }

  Color get _digitColor {
    if (isDark) return theme.borderFocus;
    return theme.textPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: AppDimensions.otpBoxWidth,
      height: AppDimensions.otpBoxHeight,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.otpBoxRadius),
        border: showBorder
            ? Border.all(
                color: theme.borderFocus,
                width: AppDimensions.otpBoxBorderWidth,
              )
            : null,
      ),
      alignment: Alignment.center,
      child: hasValue
          ? Text(digit, style: typography.h3.copyWith(color: _digitColor))
          : isFocused
          ? _OtpCursor(color: theme.borderFocus)
          : null,
    );
  }
}

class _OtpCursor extends StatefulWidget {
  const _OtpCursor({required this.color});

  final Color color;

  @override
  State<_OtpCursor> createState() => _OtpCursorState();
}

class _OtpCursorState extends State<_OtpCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(width: 2.w, height: 22.h, color: widget.color),
    );
  }
}
