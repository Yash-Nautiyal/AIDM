import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:aidm/feature/auth/presentation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

Future<void> showDeleteAccountDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => const DeleteAccountDialog(),
  );
}

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  static const _description =
      'Permanently delete your account and all associated personal '
      'data. This action cannot be undone. Financial records are retained '
      'for legal compliance but will be anonymised.';

  void _confirmDelete(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      pageRoute(page: const SignInPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: AppDimensions.pagePadding),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.backgroundPage,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          border: Border.all(color: theme.textDanger),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Danger Zone',
                style: typography.labelLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.textDanger,
                ),
              ),
              SizedBox(height: AppDimensions.spacingVerticalMd),
              Text(
                _description,
                style: typography.bodyMedium.copyWith(
                  color: theme.textSecondary,
                ),
              ),
              SizedBox(height: AppDimensions.spacingVerticalLg),
              _DeleteAccountButton(
                onPressed: () => _confirmDelete(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteAccountButton extends StatelessWidget {
  const _DeleteAccountButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Material(
      color: theme.textDanger,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.sp,
            vertical: 12.h,
          ),
          child: Text(
            'Delete my account',
            style: typography.label.copyWith(color: theme.brandPrimaryTint),
          ),
        ),
      ),
    );
  }
}
