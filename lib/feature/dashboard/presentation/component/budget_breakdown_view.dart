import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/budget/presentation/view_model/budgets_view_model.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/budget_breakdown_chart.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/dashboard_month_selector.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/budget_breakdown_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/set_budget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _kCenterRadiusScale = 0.12;
const _kBaseSectionRadiusScale = 0.18;

class BudgetBreakdownView extends StatelessWidget {
  const BudgetBreakdownView({
    required this.month,
    required this.budget,
    required this.expense,
    required this.categories,
    this.height = 200,
    super.key,
  });

  final TransactionMonth? month;
  final double budget;
  final double expense;
  final List<Category> categories;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const DashboardMonthSelector(),
          const SizedBox(height: 12),
          _BreakdownInfo(
            month: month,
            budget: budget,
            expense: expense,
          ),
          Expanded(
            child: Center(
              child: BudgetBreakdownChart(
                categories: categories,
                budget: budget,
                expense: expense,
                centerSpaceRadius: height * _kCenterRadiusScale,
                baseSectionRadius: height * _kBaseSectionRadiusScale,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BreakdownInfo extends StatelessWidget {
  const _BreakdownInfo({
    required this.month,
    required this.budget,
    required this.expense,
  });

  final TransactionMonth? month;
  final double budget;
  final double expense;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetsViewModel, BudgetsState>(
      builder: (context, state) {
        final balance = budget - expense;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              if (budget > 0)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ValueLabel(
                        label: 'BAL',
                        value: Formatter.currency(balance),
                        color: Color.lerp(
                          AppColors.fontPrimary,
                          AppColors.fontWarning,
                          (expense / budget).clamp(0, 1),
                        ),
                      ),
                      BlocBuilder<BudgetBreakdownViewModel,
                          BudgetBreakdownState>(
                        builder: (context, budgetBreakdownState) {
                          return _ValueLabel(
                            label: 'BUD',
                            value: Formatter.currency(budget),
                            suffixIcon: CustomInkWell(
                              borderRadius: 50,
                              padding: const EdgeInsets.all(4),
                              onTap: () => context
                                  .read<BudgetBreakdownViewModel>()
                                  .toggleShowRemaining(),
                              child: Icon(
                                budgetBreakdownState.showRemaining
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              else
                Expanded(
                  child: _ValueLabel(
                    label: 'EXP',
                    value: Formatter.currency(expense),
                  ),
                ),
              SetBudgetButton(
                month: month,
                budget: budget,
              ),
            ],
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
    this.color,
    this.suffixIcon,
  });

  final String label;
  final String value;
  final Color? color;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: AppTextStyles.titleExtraSmall.copyWith(
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: AppTextStyles.titleSmall.copyWith(
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        if (suffixIcon != null) suffixIcon!,
      ],
    );
  }
}
