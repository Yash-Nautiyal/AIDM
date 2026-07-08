import 'package:aidm/core/constant/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/app_dimensions.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/typography/app_typography_extension.dart';
import '../../../../core/widgets/button/app_button.dart';
import 'sign_up_page.dart';

class WelocomePage extends StatelessWidget {
  const WelocomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    // final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      body: SafeArea(
        // top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                AppAssets.welcomeScreenImg,
                // height: screenHeight * 0.5,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              // const SizedBox(height: AppDimensions.spacingLg),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.pagePadding,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome to \nWebinar!',
                      style: typography.display.copyWith(
                        color: theme.brandPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppDimensions.spacingMd),
                    Text(
                      'A single platform that widens your reach, raises the bar on every event, from marketing keynotes to large-scale broadcasts.',
                      style: typography.bodyMedium16.copyWith(
                        color: theme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // const Spacer(),
                    SizedBox(height: AppDimensions.spacing2xl),
                    AppButton1(
                      label: 'Get Started',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppDimensions.spacingLg),
            ],
          ),
        ),
      ),
    );
  }
}
