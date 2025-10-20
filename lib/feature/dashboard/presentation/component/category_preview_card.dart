import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category.dart';
import 'package:expense_tracker/feature/categories/presentation/helper/category_helper.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/dashboard_drawer_card_base.dart';
import 'package:flutter/material.dart';

class CategoryPreviewCard extends StatelessWidget {
  const CategoryPreviewCard({
    required this.category,
    required this.totalExpense,
    super.key,
  });

  final Category category;
  final double totalExpense;

  @override
  Widget build(BuildContext context) {
    final allocation = category.expense / totalExpense;
    final details = CategoryHelper.of(context).watchCategoryWithId(category.id);

    return DashboardDrawerCardBase(
      category: details,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                details.name,
                style: AppTextStyles.titleExtraSmall,
              ),
              Text(
                Formatter.currency(category.expense),
                style: AppTextStyles.titleExtraSmall.copyWith(
                  color: AppColors.fontWarning,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: LinearProgressIndicator(
                    value: allocation,
                    minHeight: 12,
                    color: details.color.colorData,
                    backgroundColor: AppColors.shadow,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                Formatter.percentage(allocation),
                style: AppTextStyles.bodyRegular.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
