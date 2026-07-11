import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/feature/auth/presentation/pages/sign_in_page.dart';
import 'package:aidm/feature/more/presenation/pages/profile_page.dart';
import 'package:aidm/feature/more/presenation/widgets/more_email_preference_section.dart';
import 'package:aidm/feature/more/presenation/widgets/more_menu_section.dart';
import 'package:aidm/feature/more/presenation/widgets/more_profile_header.dart';
import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  static const _displayName = 'Dunge';
  static const _email = 'dunge@example.com';
  static const _joinedDate = 'Joined 02 July 2026';

  void _openProfile(BuildContext context) {
    moveTo(context, const ProfilePage());
  }

  void _signOut(BuildContext context) {
    moveTo(context, const SignInPage(), clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            AppDimensions.pagePadding,
            AppDimensions.spacingVertical2xl,
            AppDimensions.pagePadding,
            AppDimensions.spacingVertical3xl,
          ),
          child: Column(
            children: [
              const MoreProfileHeader(
                displayName: _displayName,
                email: _email,
                joinedDate: _joinedDate,
              ),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              MoreMenuSection(
                items: [
                  MoreMenuIconItem(
                    title: 'Profile',
                    icon: Icons.person_outline_rounded,
                    onTap: () => _openProfile(context),
                  ),
                  MoreMenuSvgItem(
                    title: 'Attachments',
                    assetPath: AppAssets.paperClipIcon,
                  ),
                  MoreMenuSvgItem(
                    title: 'Subscription',
                    assetPath: AppAssets.premiumIcon,
                  ),
                  const MoreMenuIconItem(
                    title: 'Integration',
                    icon: Icons.code_rounded,
                  ),
                  const MoreMenuIconItem(
                    title: 'Terms & conditions',
                    icon: Icons.description_outlined,
                  ),
                  const MoreMenuIconItem(
                    title: 'Privacy policy',
                    icon: Icons.description_outlined,
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.spacingVerticalLg),
              const MoreEmailPreferenceSection(),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              GestureDetector(
                onTap: () => _signOut(context),
                child: Text(
                  'Sign Out',
                  style: typography.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.textDanger,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
