import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/budget/presentation/helper/budget_helper.dart';
import 'package:expense_tracker/feature/budget/presentation/view_model/budgets_view_model.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/budget_breakdown_chart.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/dashboard_month_selector.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/budget_breakdown_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: _ValueLabel(
                  label: 'EXP',
                  value: Formatter.currency(expense),
                ),
              ),
              Expanded(
                child: _ValueLabel(
                  label: 'BUD',
                  value: budget > 0 ? Formatter.currency(budget) : null,
                  onTap: () => month != null
                      ? BudgetHelper.of(context).showSetBudgetModal(
                          month: month!,
                          initialValue: budget,
                        )
                      : null,
                  suffixIcon: const Icon(
                    Icons.edit_document,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              Expanded(
                child:
                    BlocBuilder<BudgetBreakdownViewModel, BudgetBreakdownState>(
                  builder: (context, budgetBreakdownState) {
                    return _ValueLabel(
                      label: 'BAL',
                      value: budget > 0 ? Formatter.currency(balance) : null,
                      color: budget > 0
                          ? Color.lerp(
                              AppColors.fontPrimary,
                              AppColors.fontWarning,
                              (expense / budget).clamp(0, 1),
                            )
                          : null,
                      onTap: () => context
                          .read<BudgetBreakdownViewModel>()
                          .toggleShowRemaining(),
                      suffixIcon: Icon(
                        budgetBreakdownState.showRemaining
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                        size: 16,
                      ),
                    );
                  },
                ),
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
    this.onTap,
    this.suffixIcon,
  });

  final String label;
  final String? value;
  final Color? color;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      height: 60,
      borderRadius: 12,
      color: AppColors.widgetBackgroundSecondary,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.titleExtraSmall.copyWith(
                  color: AppColors.accent,
                ),
              ),
              if (suffixIcon != null) ...[
                const SizedBox(width: 8),
                suffixIcon!,
              ],
            ],
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value ?? 'None',
                style: value != null
                    ? AppTextStyles.titleSmall.copyWith(
                        color: color,
                      )
                    : AppTextStyles.bodyMedium.copyWith(
                        color: color ?? AppColors.fontDisabled,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
