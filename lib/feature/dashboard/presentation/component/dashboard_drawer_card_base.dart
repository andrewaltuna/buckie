import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/category_icon.dart';
import 'package:flutter/material.dart';

class DashboardDrawerCardBase extends StatelessWidget {
  const DashboardDrawerCardBase({
    required this.category,
    required this.child,
    this.onTap,
    super.key,
  });

  final CategoryDetails category;
  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
          ),
        ],
      ),
      child: CustomInkWell(
        onTap: onTap,
        color: AppColors.widgetBackgroundSecondary,
        borderRadius: 16,
        padding: const EdgeInsets.all(12),
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
      ),
    );
  }
}
