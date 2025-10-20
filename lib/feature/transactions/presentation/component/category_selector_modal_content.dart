import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/component/popup_menu/custom_popup_menu_item.dart';
import 'package:expense_tracker/common/component/scroll_view/fading_scroll_view.dart';
import 'package:expense_tracker/common/extension/context_extension.dart';
import 'package:expense_tracker/common/helper/haptic_feedback_helper.dart';
import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/common/helper/popup_menu_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/presentation/screen/create_category_screen.dart';
import 'package:expense_tracker/feature/categories/presentation/screen/update_category_screen.dart';
import 'package:expense_tracker/feature/categories/presentation/view_model/categories_view_model.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/delete_category_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

const _kItemHeight = 48.0;
const _kItemBorderRadius = 12.0;
const _kItemGap = 8.0;

class CategorySelectorModalContent extends StatelessWidget {
  const CategorySelectorModalContent({
    this.onChanged,
    this.onDeleted,
    super.key,
  });

  static const _horizontalPadding = 16.0;

  final void Function(int)? onChanged;
  final void Function(int)? onDeleted;

  void _onSelect(
    BuildContext context,
    int id,
  ) {
    HapticFeedbackHelper.light();

    Navigator.pop(context);

    onChanged?.call(id);
  }

  void _onLongPressStart(
    BuildContext context,
    CategoryDetails category,
    LongPressStartDetails details,
  ) async {
    HapticFeedbackHelper.light();

    await PopupMenuHelper.of(context).showPopupMenu(
      position: details.globalPosition,
      items: [
        CustomPopupMenuItem<String>(
          onTap: (_) {
            UpdateCategoryScreen.navigateTo(
              context: context,
              category: category,
            );

            Navigator.of(context).pop();
          },
          value: 'edit',
          label: 'Edit',
          icon: Icons.edit,
        ),
        CustomPopupMenuItem<String>(
          onTap: (_) {
            _showDeleteConfirmation(
              context,
              category.id,
            );

            Navigator.of(context).pop();
          },
          value: 'delete',
          label: 'Delete',
          icon: Icons.delete,
          color: AppColors.fontWarning,
        ),
      ],
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    int id,
  ) {
    ModalHelper.of(context).showModal(
      builder: (modalCtx) => DeleteCategoryModalContent(
        onDeleted: () {
          context
              .read<CategoriesViewModel>()
              .add(CategoriesItemDeleted(id: id));
          Navigator.of(modalCtx).pop();
          onDeleted?.call(id);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = _calculateAspectRatio(context);
    final (
      customCategories,
      defaultCategories,
    ) = context.select(
      (CategoriesViewModel vm) => (
        vm.state.customCategories,
        vm.state.defaultCategories,
      ),
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
            child: FadingScrollView(
              bottom: false,
              gradientColor: AppColors.widgetBackgroundPrimary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (customCategories.isNotEmpty) ...[
                    _GridView(
                      label: 'Custom Categories',
                      aspectRatio: aspectRatio,
                      categories: customCategories,
                      onLongPressStart: (category, details) =>
                          _onLongPressStart(
                        context,
                        category,
                        details,
                      ),
                      onSelect: (id) => _onSelect(context, id),
                    ),
                    const SizedBox(height: 16),
                  ],
                  _GridView(
                    label: 'Default Categories',
                    aspectRatio: aspectRatio,
                    categories: defaultCategories,
                    onSelect: (id) => _onSelect(context, id),
                  ),
                  SizedBox(height: context.padding.bottom),
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
          onTap: () => context.pushNamed(CreateCategoryScreen.routeName),
          color: AppColors.accent,
          borderRadius: _kItemBorderRadius,
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
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
    this.onLongPressStart,
  });

  final String? label;
  final double aspectRatio;
  final List<CategoryDetails> categories;
  final void Function(int) onSelect;
  final void Function(CategoryDetails, LongPressStartDetails)? onLongPressStart;

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
          padding: EdgeInsets.zero,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];

            return CustomInkWell(
              onTap: () => onSelect(category.id),
              onLongPressStart: (details) => onLongPressStart?.call(
                category,
                details,
              ),
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
                    category.name,
                    style: AppTextStyles.bodyRegular,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
