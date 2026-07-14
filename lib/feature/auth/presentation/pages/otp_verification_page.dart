import 'dart:async';

import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/button/app_button.dart';
import 'package:aidm/core/widgets/input/app_otp_input.dart';
import 'package:aidm/feature/auth/domain/repositories/auth_repository.dart';
import 'package:aidm/feature/auth/domain/usecases/resend_otp.dart';
import 'package:aidm/feature/auth/domain/usecases/verify_otp.dart';
import 'package:aidm/feature/auth/presentation/bloc/verify_otp/verify_otp_cubit.dart';
import 'package:aidm/feature/auth/presentation/bloc/verify_otp/verify_otp_state.dart';
import 'package:aidm/core/routes/auth_routes.dart';
import 'package:aidm/feature/auth/presentation/widgets/auth_back_button.dart';
import 'package:aidm/feature/auth/presentation/widgets/auth_legal_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyOtpCubit(
        verifyOtp: VerifyOtp(context.read<AuthRepository>()),
        resendOtp: ResendOtp(context.read<AuthRepository>()),
      ),
      child: _OtpVerificationView(email: email),
    );
  }
}

class _OtpVerificationView extends StatefulWidget {
  const _OtpVerificationView({required this.email});

  final String email;

  @override
  State<_OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<_OtpVerificationView> {
  static const _initialSeconds = 272;

  final _otpInputKey = GlobalKey<AppOtpInputState>();

  String _otp = '';
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

  void _handleVerify() {
    if (!_isOtpComplete) return;

    context.read<VerifyOtpCubit>().verify(email: widget.email, otp: _otp);
  }

  void _handleResend() {
    context.read<VerifyOtpCubit>().resend(widget.email);
  }

  void _handleOtpChanged(String value) {
    setState(() => _otp = value);
    context.read<VerifyOtpCubit>().clearError();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return BlocListener<VerifyOtpCubit, VerifyOtpState>(
      listener: (context, state) {
        switch (state) {
          case VerifyOtpSuccess(:final result):
            AuthRoutes.navigateAfterVerifyOtp(context, result);
          case VerifyOtpResent():
            _otpInputKey.currentState?.clear();
            setState(() => _otp = '');
            _startTimer();
          default:
            break;
        }
      },
      child: BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
        builder: (context, state) {
          final isVerifying = state is VerifyOtpVerifying;
          final isResending = state is VerifyOtpResending;
          final isBusy = isVerifying || isResending;
          final errorMessage = state is VerifyOtpFailure ? state.message : null;

          return Scaffold(
            backgroundColor: theme.backgroundPage,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: AppDimensions.pagePadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthBackButton(
                        onPressed: () => AuthRoutes.backFromOtpVerification(context),
                      enabled: !isBusy,
                    ),
                    SizedBox(height: AppDimensions.spacingMd),
                    SvgPicture.asset(
                      AppAssets.appLogo,
                      width: AppDimensions.logoWidth,
                      height: AppDimensions.logoHeight,
                    ),
                    SizedBox(height: AppDimensions.spacingMd),
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
                        style: typography.bodyMedium16.copyWith(
                          color: theme.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: AppDimensions.spacingXs),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Code sent to ${widget.email}',
                        style: typography.body.copyWith(
                          color: theme.textTertiary,
                        ),
                      ),
                    ),
                    SizedBox(height: AppDimensions.spacingLg),
                    AppOtpInput(
                      key: _otpInputKey,
                      onChanged: _handleOtpChanged,
                      onCompleted: (_) => _handleVerify(),
                    ),
                    SizedBox(height: AppDimensions.spacingLg),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
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
                    ),
                    SizedBox(height: AppDimensions.spacing3xl),
                    if (errorMessage != null) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorMessage,
                          style: typography.bodyMedium.copyWith(
                            color: theme.textDanger,
                          ),
                        ),
                      ),
                      SizedBox(height: AppDimensions.spacingMd),
                    ],
                    AppButton(
                      label: 'Verify',
                      enabled: _isOtpComplete,
                      isLoading: isVerifying,
                      onPressed: _isOtpComplete && !isBusy
                          ? _handleVerify
                          : null,
                    ),
                    SizedBox(height: AppDimensions.spacingLg),
                    GestureDetector(
                      onTap: isBusy ? null : _handleResend,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: typography.bodyMedium.copyWith(
                            color: theme.textPrimary,
                          ),
                          children: [
                            TextSpan(
                              text: isResending
                                  ? 'Resending code... '
                                  : "Didn't receive the code? ",
                            ),
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
        },
      ),
    );
  }
}
