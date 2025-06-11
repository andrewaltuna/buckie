import 'package:expense_tracker/feature/categories/data/model/budget_category.dart';
import 'package:expense_tracker/feature/categories/presentation/view_model/categories_view_model.dart';
import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/budget_breakdown_chart.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/budget_breakdown_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetBreakdownDisplay extends StatelessWidget {
  const BudgetBreakdownDisplay({
    super.key,
    required this.totalBudget,
    required this.categories,
    this.height = 200,
  });

  final double totalBudget;
  final List<BudgetCategory> categories;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          const SizedBox(height: 15),
          const _BalanceDisplay(),
          Expanded(
            child: Center(
              child: BudgetBreakdownChart(
                centerSpaceRadius: 50,
                categories: categories,
                totalBudget: totalBudget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceDisplay extends StatelessWidget {
  const _BalanceDisplay();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesViewModel, CategoriesState>(
      builder: (context, categoriesState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.widgetBackgroundSecondary,
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ValueLabel(
                    label: 'BAL',
                    value: categoriesState.allBalanceTotalDisplay,
                  ),
                  BlocBuilder<BudgetBreakdownViewModel, BudgetBreakdownState>(
                    builder: (context, budgetBreakdownState) {
                      return _ValueLabel(
                        label: 'TOT',
                        value: categoriesState.allBudgetTotalDisplay,
                        suffixIcon: IconButton(
                          onPressed: () => context
                              .read<BudgetBreakdownViewModel>()
                              .toggleShowRemaining(),
                          iconSize: 22,
                          icon: Icon(
                            budgetBreakdownState.showRemaining
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ValueLabel extends StatelessWidget {
  const _ValueLabel({
    required this.label,
    required this.value,
    this.suffixIcon,
  });

  final String label;
  final String value;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
              fontFamily: Constants.fontFamilySecondary,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.fontPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (suffixIcon != null) suffixIcon!,
        ],
      ),
    );
  }
}
