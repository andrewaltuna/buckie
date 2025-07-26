import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/extension/screen_size.dart';
import 'package:expense_tracker/common/helper/haptic_feedback_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/presentation/view_model/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _kBorderRadius = 12.0;

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    required this.category,
    this.onChanged,
    super.key,
  });

  final CategoryDetails category;
  final void Function(String)? onChanged;

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
          color: category.color.colorData,
          borderRadius: 12,
          child: Container(
            height: 48,
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  category.icon.iconData,
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

  static const _gap = 8.0;
  static const _horizontalPadding = 16.0;

  final void Function(String)? onChanged;

  void _onSelect(
    BuildContext context,
    String categoryId,
  ) {
    HapticFeedbackHelper.light();

    Navigator.pop(context);

    onChanged?.call(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidthAfterPadding =
        context.width - _gap - (_horizontalPadding * 2);
    final aspectRatio = (screenWidthAfterPadding / 2) / 48;

    final categories = context.select(
      (CategoriesViewModel vm) => vm.state.categories,
    );

    const defaultCategories = CategoryDetails.defaultCategories;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Category',
                style: AppTextStyles.titleMedium,
              ),
              CustomInkWell(
                color: AppColors.accent,
                borderRadius: _kBorderRadius,
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.add_circle,
                      color: AppColors.fontButtonPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Create',
                      style: AppTextStyles.buttonRegular.copyWith(
                        color: AppColors.fontButtonPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Custom',
                    style: AppTextStyles.titleSmall,
                  ),
                  const SizedBox(height: _gap),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: aspectRatio,
                      mainAxisSpacing: _gap,
                      crossAxisSpacing: _gap,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return CustomInkWell(
                          color: AppColors.widgetBackgroundSecondary,
                          borderRadius: _kBorderRadius,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColors.fontPrimary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Create',
                                style: AppTextStyles.bodyRegular,
                              ),
                            ],
                          ),
                        );
                      }

                      final category = categories[index - 1];

                      return CustomInkWell(
                        onTap: () => _onSelect(context, category.id),
                        borderRadius: _kBorderRadius,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        color: category.color.colorData,
                        child: Row(
                          children: [
                            Icon(
                              category.icon.iconData,
                              color: AppColors.fontPrimary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              category.label,
                              style: AppTextStyles.bodyRegular,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: categories.length + 1,
                  ),
                  const Divider(
                    height: 32,
                    color: AppColors.fontDisabled,
                    indent: 16,
                    endIndent: 16,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: aspectRatio,
                      mainAxisSpacing: _gap,
                      crossAxisSpacing: _gap,
                    ),
                    itemBuilder: (context, index) {
                      final category = defaultCategories[index];

                      return CustomInkWell(
                        onTap: () => _onSelect(context, category.id),
                        borderRadius: _kBorderRadius,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        color: category.color.colorData,
                        child: Row(
                          children: [
                            Icon(
                              category.icon.iconData,
                              color: AppColors.fontPrimary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              category.label,
                              style: AppTextStyles.bodyRegular,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: defaultCategories.length,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
