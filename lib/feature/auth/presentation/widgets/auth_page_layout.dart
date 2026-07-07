import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:aidm/core/widgets/button/app_button1.dart';
import 'package:aidm/core/widgets/input/app_input1.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthPageLayout extends StatefulWidget {
  const AuthPageLayout({
    super.key,
    required this.title,
    required this.buttonLabel,
    required this.secondaryPrefix,
    required this.secondaryActionLabel,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
  });

  final String title;
  final String buttonLabel;
  final String secondaryPrefix;
  final String secondaryActionLabel;
  final ValueChanged<String> onPrimaryPressed;
  final VoidCallback onSecondaryPressed;

  @override
  State<AuthPageLayout> createState() => _AuthPageLayoutState();
}

class _AuthPageLayoutState extends State<AuthPageLayout> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.pagePadding,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(height: AppDimensions.spacing3xl),
                      SvgPicture.asset(
                        'assets/logo/logo 1.svg',
                        width: 120.w,
                        height: 84.h,
                      ),
                      SizedBox(height: AppDimensions.spacing3xl),
                      Text(
                        widget.title,
                        style: typography.display.copyWith(
                          color: theme.brandPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppDimensions.spacing3xl),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: typography.labelMedium.copyWith(
                            color: theme.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(height: AppDimensions.spacingSm),
                      AppInput(
                        controller: _emailController,
                        hintText: 'Enter your email ID',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _handlePrimaryPressed(),
                      ),
                      SizedBox(height: AppDimensions.spacingSm),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "We’ll never share your email with anyone else.",
                          style: typography.captionLight.copyWith(
                            color: theme.textTertiary,
                          ),
                        ),
                      ),
                      SizedBox(height: AppDimensions.spacing2xl),
                      AppButton1(
                        label: widget.buttonLabel,
                        onPressed: _handlePrimaryPressed,
                      ),
                      SizedBox(height: AppDimensions.spacingLg),
                      GestureDetector(
                        onTap: widget.onSecondaryPressed,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: typography.bodyMedium.copyWith(
                              color: theme.textPrimary,
                            ),
                            children: [
                              TextSpan(text: widget.secondaryPrefix),
                              TextSpan(
                                text: widget.secondaryActionLabel,
                                style: typography.bodyMedium.copyWith(
                                  color: theme.brandPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          top: AppDimensions.spacing3xl,
                          bottom: AppDimensions.spacingLg,
                        ),
                        child: _LegalFooter(
                          theme: theme,
                          typography: typography,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handlePrimaryPressed() {
    widget.onPrimaryPressed(_emailController.text.trim());
  }
}

class _LegalFooter extends StatelessWidget {
  const _LegalFooter({required this.theme, required this.typography});

  final AppThemeExtension theme;
  final AppTypographyExtension typography;

  @override
  Widget build(BuildContext context) {
    final baseStyle = typography.captionLight.copyWith(
      color: theme.textPrimary,
    );
    final boldStyle = typography.captionBold.copyWith(color: theme.textPrimary);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: 'By proceeding, you agree to our '),
          TextSpan(
            text: 'Terms',
            style: boldStyle,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: boldStyle,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
