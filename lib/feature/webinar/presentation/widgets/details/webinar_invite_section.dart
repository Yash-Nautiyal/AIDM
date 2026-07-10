import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/feature/webinar/presentation/widgets/details/webinar_copy_field.dart';
import 'package:flutter/material.dart';

class WebinarInviteSection extends StatelessWidget {
  const WebinarInviteSection({
    super.key,
    required this.inviteLink,
    required this.code,
  });

  final String inviteLink;
  final String code;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        border: Border.all(color: theme.borderDefault),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppDimensions.spacingLg),
            child: WebinarCopyField(label: 'Invite Link', value: inviteLink),
          ),
          Divider(height: 1, thickness: 1, color: theme.borderDefault),
          Padding(
            padding: EdgeInsets.all(AppDimensions.spacingLg),
            child: WebinarCopyField(label: 'Code', value: code),
          ),
        ],
      ),
    );
  }
}
