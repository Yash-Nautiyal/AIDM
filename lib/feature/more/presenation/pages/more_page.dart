import 'package:aidm/core/constant/app_assets.dart';
import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/feature/auth/presentation/bloc/session/session_bloc.dart';
import 'package:aidm/feature/auth/presentation/bloc/session/session_event.dart';
import 'package:aidm/feature/auth/presentation/bloc/session/session_state.dart';
import 'package:aidm/feature/more/presenation/pages/attachments_page.dart';
import 'package:aidm/feature/more/presenation/pages/integration_page.dart';
import 'package:aidm/feature/more/presenation/pages/profile_page.dart';
import 'package:aidm/feature/more/presenation/pages/subscription_page.dart';
import 'package:aidm/feature/more/presenation/widgets/more/more_email_preference_section.dart';
import 'package:aidm/feature/more/presenation/widgets/more/more_menu_section.dart';
import 'package:aidm/feature/more/presenation/widgets/more/more_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  static const _joinedDate = 'Joined 02 July 2026';

  void _openProfile(BuildContext context) {
    moveTo(context, const ProfilePage());
  }

  void _openAttachments(BuildContext context) {
    moveTo(context, const AttachmentsPage());
  }

  void _openSubscription(BuildContext context) {
    moveTo(context, const SubscriptionPage());
  }

  void _openIntegration(BuildContext context) {
    moveTo(context, const IntegrationPage());
  }

  void _signOut(BuildContext context) {
    context.read<SessionBloc>().add(const SessionSignedOut());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final user = context.watch<SessionBloc>().state.sessionOrNull;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.pagePadding,
          child: Column(
            children: [
              MoreProfileHeader(
                displayName: user?.greetingName ?? '',
                email: user?.email ?? '',
                joinedDate: _joinedDate,
              ),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              MoreMenuSection(
                items: [
                  MoreMenuSvgItem(
                    title: 'Profile',
                    assetPath: AppAssets.userIcon,
                    onTap: () => _openProfile(context),
                  ),
                  MoreMenuSvgItem(
                    title: 'Attachments',
                    assetPath: AppAssets.paperClipIcon,
                    onTap: () => _openAttachments(context),
                  ),
                  MoreMenuSvgItem(
                    title: 'Subscription',
                    assetPath: AppAssets.premiumIcon,
                    onTap: () => _openSubscription(context),
                  ),
                  MoreMenuSvgItem(
                    title: 'Integration',
                    assetPath: AppAssets.codeIcon,
                    iconSize: AppDimensions.iconSizeSm,
                    onTap: () => _openIntegration(context),
                  ),
                  const MoreMenuSvgItem(
                    title: 'Terms & conditions',
                    assetPath: AppAssets.fileIcon,
                  ),
                  const MoreMenuSvgItem(
                    title: 'Privacy policy',
                    assetPath: AppAssets.fileIcon,
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
                  style: typography.label.copyWith(color: theme.textDanger),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
