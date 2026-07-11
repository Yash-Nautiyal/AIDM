import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:aidm/feature/more/presenation/widgets/delete_account_dialog.dart';
import 'package:aidm/feature/more/presenation/widgets/profile_avatar_editor.dart';
import 'package:aidm/feature/more/presenation/widgets/profile_labeled_field.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const routeName = '/more/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: 'Dunge');
    _lastNameController = TextEditingController();
    _emailController = TextEditingController(text: 'dunge@example.com');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onSave() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: AppAppBar(
        title: 'Profile',
        showBack: true,
        onBack: () => Navigator.of(context).pop(),
        actions: [
          TextButton(
            onPressed: _onSave,
            child: Text(
              'Save',
              style: typography.bodyMedium.copyWith(
                color: theme.textLink,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
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
              ProfileAvatarEditor(
                displayName: _firstNameController.text,
                onEditTap: () {},
              ),
              SizedBox(height: AppDimensions.spacingVertical3xl),
              ProfileLabeledField(
                label: 'First name',
                controller: _firstNameController,
              ),
              SizedBox(height: AppDimensions.spacingVerticalLg),
              ProfileLabeledField(
                label: 'Last name',
                controller: _lastNameController,
                hintText: 'Last name',
              ),
              SizedBox(height: AppDimensions.spacingVerticalLg),
              ProfileLabeledField(
                label: 'Email ID',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: AppDimensions.spacingVertical3xl),
              GestureDetector(
                onTap: () => showDeleteAccountDialog(context),
                child: Text(
                  'Delete my account',
                  style: typography.bodyMedium.copyWith(
                    color: theme.textDanger,
                    fontWeight: FontWeight.w500,
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
