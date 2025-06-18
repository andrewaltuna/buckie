import 'package:expense_tracker/common/extension/screen_size.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/categories/data/model/transaction_category.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/category_display.dart';
import 'package:flutter/material.dart';

const _kBorderRadius = 12.0;

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    required this.category,
    this.onChanged,
    super.key,
  });

  final TransactionCategoryType category;
  final void Function(TransactionCategoryType)? onChanged;

  void _onTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(_kBorderRadius),
        ),
      ),
      backgroundColor: AppColors.widgetBackgroundPrimary,
      builder: (_) => _Selector(
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

        return CategoryDisplay(
          height: 48,
          category: category,
          trailingSpace: trailingSpace,
          onTap: () => _onTap(context),
        );
      },
    );
  }
}

class _Selector extends StatelessWidget {
  const _Selector({
    required this.onChanged,
  });

  final void Function(TransactionCategoryType)? onChanged;

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
              'Select a category',
              style: TextStyles.titleMedium,
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
                final category = TransactionCategoryType.values[index];

                return InkWell(
                  onTap: () {
                    onChanged?.call(category);
                    Navigator.pop(context);
                  },
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
                          style: TextStyles.bodyRegular,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: TransactionCategoryType.values.length,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
