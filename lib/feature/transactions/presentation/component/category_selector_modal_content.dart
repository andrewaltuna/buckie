import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/extension/context_extension.dart';
import 'package:expense_tracker/common/helper/haptic_feedback_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/presentation/view_model/categories_view_model.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/create_category_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _kItemHeight = 48.0;
const _kItemBorderRadius = 12.0;
const _kItemGap = 8.0;

class CategorySelectorModalContent extends StatelessWidget {
  const CategorySelectorModalContent({
    required this.onChanged,
    super.key,
  });

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
    final aspectRatio = _calculateAspectRatio(context);
    final categories = context.select(
      (CategoriesViewModel vm) => vm.state.categories,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const _Header(),
          const SizedBox(height: 16),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (categories.isNotEmpty) ...[
                    _GridView(
                      aspectRatio: aspectRatio,
                      categories: categories,
                      onSelect: (categoryId) => _onSelect(
                        context,
                        categoryId,
                      ),
                    ),
                    const Divider(
                      height: 32,
                      color: AppColors.fontDisabled,
                      indent: 16,
                      endIndent: 16,
                    ),
                  ],
                  _GridView(
                    label: 'Default Categories',
                    aspectRatio: aspectRatio,
                    categories: CategoryDetails.defaultCategories,
                    onSelect: (categoryId) => _onSelect(
                      context,
                      categoryId,
                    ),
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

  double _calculateAspectRatio(BuildContext context) {
    final contentWidthAfterPadding =
        context.width - _kItemGap - (_horizontalPadding * 2);

    return (contentWidthAfterPadding / 2) / _kItemHeight;
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Select Category',
          style: AppTextStyles.titleMedium,
        ),
        CustomInkWell(
          color: AppColors.accent,
          borderRadius: _kItemBorderRadius,
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CreateCategoryModalContent(),
              ),
            );
          },
          child: Row(
            children: [
              const Icon(
                Icons.add_circle,
                color: AppColors.fontButtonPrimary,
              ),
              const SizedBox(width: 8),
              Text(
                'Add',
                style: AppTextStyles.buttonRegular.copyWith(
                  color: AppColors.fontButtonPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GridView extends StatelessWidget {
  const _GridView({
    required this.aspectRatio,
    required this.categories,
    required this.onSelect,
    this.label,
    this.onLongPress,
  });

  final String? label;
  final double aspectRatio;
  final List<CategoryDetails> categories;
  final void Function(String) onSelect;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: _kItemGap),
        ],
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: aspectRatio,
            mainAxisSpacing: _kItemGap,
            crossAxisSpacing: _kItemGap,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];

            return CustomInkWell(
              onTap: () => onSelect(category.id),
              onLongPress: onLongPress,
              borderRadius: _kItemBorderRadius,
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
          itemCount: categories.length,
        ),
      ],
    );
  }
}
