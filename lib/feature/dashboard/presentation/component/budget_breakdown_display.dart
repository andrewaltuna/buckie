import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/budget/presentation/view_model/budgets_view_model.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/budget_breakdown_chart.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/dashboard_month_selector.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/budget_breakdown_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _kCenterRadiusScale = 0.12;
const _kBaseSectionRadiusScale = 0.18;

class BudgetBreakdownDisplay extends StatelessWidget {
  const BudgetBreakdownDisplay({
    required this.budget,
    required this.expense,
    required this.categories,
    this.height = 200,
    super.key,
  });

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
          const SizedBox(height: 16),
          _BreakdownInfo(
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
    required this.budget,
    required this.expense,
  });

  final double budget;
  final double expense;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetsViewModel, BudgetsState>(
      builder: (context, state) {
        final balance = budget - expense;

        return Container(
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.widgetBackgroundSecondary,
          ),
          child: budget > 0
              ? Row(
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
                    BlocBuilder<BudgetBreakdownViewModel, BudgetBreakdownState>(
                      builder: (context, budgetBreakdownState) {
                        return _ValueLabel(
                          label: 'CAP',
                          value: Formatter.currency(budget),
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
                )
              : _ValueLabel(
                  label: 'EXP',
                  value: Formatter.currency(expense),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyles.titleExtraSmall.copyWith(
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: TextStyles.titleSmall.copyWith(
              color: color,
            ),
          ),
          if (suffixIcon != null) suffixIcon!,
        ],
      ),
    );
  }
}
