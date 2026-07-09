import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:flutter/material.dart';

import 'show_app_bottom_sheet.dart';

Future<String?> showAppBottomSheetOptions(
  BuildContext context, {
  required List<String> options,
  required String selected,
}) {
  return showAppBottomSheet<String>(
    context,
    showHeaderDivider: false,
    padding: EdgeInsets.symmetric(
      horizontal: AppDimensions.pagePadding,
      vertical: AppDimensions.spacingVerticalLg,
    ),
    body: AppBottomSheetOptionsList(
      options: options,
      selected: selected,
      onSelected: (value) => Navigator.of(context).pop(value),
    ),
  );
}

class AppBottomSheetOptionsList extends StatelessWidget {
  const AppBottomSheetOptionsList({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(options.length, (index) {
        final value = options[index];
        final isSelected = value == selected;
        return Column(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onSelected(value),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.spacingVerticalLg,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 28,
                        child: isSelected
                            ? Icon(
                                Icons.check_rounded,
                                color: theme.brandPrimary,
                                size: 18,
                              )
                            : const SizedBox.shrink(),
                      ),
                      Expanded(
                        child: Text(
                          value,
                          style: typography.bodyMedium.copyWith(
                            color: isSelected
                                ? theme.brandPrimary
                                : theme.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (index != options.length - 1)
              Divider(color: theme.borderDefault, height: 1),
          ],
        );
      }),
    );
  }
}
