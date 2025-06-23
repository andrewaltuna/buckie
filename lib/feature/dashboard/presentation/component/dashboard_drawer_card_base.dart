import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/category_icon.dart';
import 'package:flutter/material.dart';

class DashboardDrawerCardBase extends StatelessWidget {
  const DashboardDrawerCardBase({
    required this.category,
    required this.child,
    super.key,
  });

  final CategoryType category;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.widgetBackgroundSecondary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          CategoryIcon(
            category: category,
            size: 40,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
