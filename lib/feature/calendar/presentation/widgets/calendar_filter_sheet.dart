import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/utils/responsive_extension.dart';
import 'package:aidm/core/routes/app_router.dart';
import 'package:aidm/core/widgets/bottom_sheet/show_app_bottom_sheet.dart';
import 'package:flutter/material.dart';

Future<T?> showCalendarFilterSheet<T>({
  required BuildContext context,
  required String title,
  required List<T> options,
  required T selected,
  required String Function(T option) labelBuilder,
}) {
  return showAppBottomSheet<T>(
    context,
    showHeaderDivider: false,
    padding: EdgeInsets.zero,
    body: _CalendarFilterSheetBody<T>(
      title: title,
      options: options,
      selected: selected,
      labelBuilder: labelBuilder,
    ),
  );
}

class _CalendarFilterSheetBody<T> extends StatefulWidget {
  const _CalendarFilterSheetBody({
    required this.title,
    required this.options,
    required this.selected,
    required this.labelBuilder,
  });

  final String title;
  final List<T> options;
  final T selected;
  final String Function(T option) labelBuilder;

  @override
  State<_CalendarFilterSheetBody<T>> createState() =>
      _CalendarFilterSheetBodyState<T>();
}

class _CalendarFilterSheetBodyState<T>
    extends State<_CalendarFilterSheetBody<T>> {
  late T _selected = widget.selected;

  void _handleDone() => moveBack(context, _selected);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.pagePadding,
            vertical: AppDimensions.spacingVerticalMd,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => moveBack(context),
                icon: Icon(
                  Icons.chevron_left_rounded,
                  color: theme.textPrimary,
                  size: 26.sp,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Expanded(
                child: Text(
                  widget.title,
                  style: typography.h3.copyWith(color: theme.textPrimary),
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                onPressed: _handleDone,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Done',
                  style: typography.label.copyWith(color: theme.brandPrimary),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1, thickness: 1, color: theme.borderDefault),
        ...List.generate(widget.options.length, (index) {
          final option = widget.options[index];
          final isSelected = option == _selected;
          final label = widget.labelBuilder(option);

          return Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => setState(() => _selected = option),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.pagePadding,
                      vertical: AppDimensions.spacingVerticalLg,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            label,
                            style: typography.bodyMedium.copyWith(
                              color: isSelected
                                  ? theme.brandPrimary
                                  : theme.textPrimary,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_rounded,
                            color: theme.brandPrimary,
                            size: 20.sp,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (index != widget.options.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: theme.borderDefault,
                  indent: AppDimensions.pagePadding,
                  endIndent: AppDimensions.pagePadding,
                ),
            ],
          );
        }),
        SizedBox(height: AppDimensions.spacingVertical2xl),
      ],
    );
  }
}
