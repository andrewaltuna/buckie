import 'package:expense_tracker/categories/models/budget_category.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class CategoryPreviewCard extends StatelessWidget {
  const CategoryPreviewCard({
    super.key,
    required this.category,
  });

  final BudgetCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.widgetBackgroundSecondary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: Colors.white.withOpacity(0.8),
              color: category.color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              category.icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category.label,
                      style: const TextStyle(
                        color: AppColors.fontPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${category.amountRemainingDisplay} LEFT',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.fontSubtitle,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
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
                          value: category.percentageSpent,
                          minHeight: 15,
                          color: category.color,
                          backgroundColor: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${category.percentageSpentDisplay}%',
                      style: TextStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
