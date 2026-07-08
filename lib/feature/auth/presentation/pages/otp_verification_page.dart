import 'dart:async';

import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/button/app_button1.dart';
import 'package:aidm/core/widgets/input/app_otp_input.dart';
import 'package:aidm/feature/auth/presentation/widgets/auth_legal_footer.dart';
import 'package:aidm/feature/dashboard/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  static const _initialSeconds = 272; // 4:32

  final _otpInputKey = GlobalKey<AppOtpInputState>();

  String _otp = '';
  bool _isLoading = false;
  int _remainingSeconds = _initialSeconds;
  Timer? _timer;

  bool get _isOtpComplete => _otp.length == 6;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _remainingSeconds = _initialSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        setState(() => _remainingSeconds = 0);
        return;
      }
      setState(() => _remainingSeconds--);
    });
  }

  String get _formattedTimer {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _handleVerify() async {
    if (!_isOtpComplete || _isLoading) return;

    setState(() => _isLoading = true);

    await Future<void>.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPage()),
      (_) => false,
    );
  }

  void _handleResend() {
    _otpInputKey.currentState?.clear();
    setState(() {
      _otp = '';
      _isLoading = false;
    });
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.pagePadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: AppDimensions.spacing3xl),
              SvgPicture.asset(
                'assets/logo/logo 1.svg',
                width: AppDimensions.logoWidth,
                height: AppDimensions.logoHeight,
              ),
              SizedBox(height: AppDimensions.spacing3xl),
              Text(
                'Enter Verification\nCode',
                style: typography.h1.copyWith(color: theme.brandPrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.spacing3xl),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Verification Code',
                  style: typography.labelMedium.copyWith(
                    color: theme.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.spacingXs),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Code sent to ${widget.email}',
                  style: typography.captionLight.copyWith(
                    color: theme.textTertiary,
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.spacingLg),
              Flexible(
                child: AppOtpInput(
                  key: _otpInputKey,
                  onChanged: (value) => setState(() => _otp = value),
                  onCompleted: (_) => _handleVerify(),
                ),
              ),
              SizedBox(height: AppDimensions.spacingLg),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: typography.bodyMedium.copyWith(
                    color: theme.textSecondary,
                  ),
                  children: [
                    const TextSpan(text: 'Code expires in '),
                    TextSpan(
                      text: _formattedTimer,
                      style: typography.bodyMedium.copyWith(
                        color: theme.brandPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppDimensions.spacing3xl),
              AppButton1(
                label: 'Verify',
                enabled: _isOtpComplete,
                isLoading: _isLoading,
                onPressed: _isOtpComplete && !_isLoading ? _handleVerify : null,
              ),
              SizedBox(height: AppDimensions.spacingLg),
              GestureDetector(
                onTap: _isLoading ? null : _handleResend,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: typography.bodyMedium.copyWith(
                      color: theme.textPrimary,
                    ),
                    children: [
                      const TextSpan(text: "Didn't receive the code? "),
                      TextSpan(
                        text: 'Resend Code',
                        style: typography.bodyMedium.copyWith(
                          color: theme.brandPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: AppDimensions.spacing3xl,
                  bottom: AppDimensions.spacingLg,
                ),
                child: const AuthLegalFooter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
