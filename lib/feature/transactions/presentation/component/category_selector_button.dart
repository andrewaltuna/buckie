import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/category_selector_modal_content.dart';
import 'package:flutter/material.dart';

class CategorySelectorButton extends StatelessWidget {
  const CategorySelectorButton({
    required this.category,
    this.onChanged,
    this.onDeleted,
    super.key,
  });

  final CategoryDetails category;
  final void Function(int)? onChanged;
  final void Function(int)? onDeleted;

  void _onTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      backgroundColor: AppColors.widgetBackgroundPrimary,
      builder: (_) => CategorySelectorModalContent(
        onChanged: onChanged,
        onDeleted: onDeleted,
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
            height: 46,
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
                  category.name,
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
