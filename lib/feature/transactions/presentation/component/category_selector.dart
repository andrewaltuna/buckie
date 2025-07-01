import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/extension/screen_size.dart';
import 'package:expense_tracker/common/helper/haptic_feedback_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';
import 'package:flutter/material.dart';

const _kBorderRadius = 12.0;

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    required this.category,
    this.onChanged,
    super.key,
  });

  final CategoryType category;
  final void Function(CategoryType)? onChanged;

  void _onTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(_kBorderRadius),
        ),
      ),
      backgroundColor: AppColors.widgetBackgroundPrimary,
      builder: (_) => _SelectionMenu(
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Visually center category label
        final trailingSpace = constraints.maxWidth * 0.06;

        return CustomInkWell(
          onTap: () => _onTap(context),
          color: category.color,
          borderRadius: 12,
          child: Container(
            height: 48,
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  category.icon,
                  color: AppColors.fontPrimary,
                ),
                const SizedBox(width: 8),
                Text(
                  category.label,
                  style: AppTextStyles.bodyMedium,
                ),
                SizedBox(width: trailingSpace),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SelectionMenu extends StatelessWidget {
  const _SelectionMenu({
    required this.onChanged,
  });

  final void Function(CategoryType)? onChanged;

  void _onSelect(
    BuildContext context,
    CategoryType category,
  ) {
    HapticFeedbackHelper.light();

    Navigator.pop(context);

    onChanged?.call(category);
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = ((context.width - 48) / 2) / 48;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Select Category',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 16),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: aspectRatio,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final category = CategoryType.values[index];

                return InkWell(
                  onTap: () => _onSelect(context, category),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(_kBorderRadius),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: category.color,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(_kBorderRadius),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          category.icon,
                          color: AppColors.fontPrimary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category.label,
                          style: AppTextStyles.bodyRegular,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: CategoryType.values.length,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
