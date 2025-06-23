import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/dashboard/presentation/helper/budget_usage_display_helper.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/budget_breakdown_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _kSectionGap = 2.0;

class BudgetBreakdownChart extends StatelessWidget {
  const BudgetBreakdownChart({
    required this.budget,
    required this.expense,
    required this.categories,
    this.centerSpaceRadius = 50,
    this.baseSectionRadius = 65,
    super.key,
  });

  final double budget;
  final double expense;
  final List<Category> categories;
  final double centerSpaceRadius;
  final double baseSectionRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          BudgetUsageDisplayHelper.percentageUsedDisplay(
            expense: expense,
            budget: budget,
          ),
          style: TextStyles.titleMedium.copyWith(
            color: budget > 0
                ? Color.lerp(
                    AppColors.fontPrimary,
                    AppColors.fontWarning,
                    (expense / budget).clamp(0, 1),
                  )
                : null,
          ),
        ),
        _PieChart(
          budget: budget,
          expense: expense,
          categories: categories,
          centerSpaceRadius: centerSpaceRadius,
          baseSectionRadius: baseSectionRadius,
        ),
      ],
    );
  }
}

class _PieChart extends StatelessWidget {
  const _PieChart({
    required this.budget,
    required this.expense,
    required this.categories,
    required this.centerSpaceRadius,
    required this.baseSectionRadius,
  });

  final double budget;
  final double expense;
  final List<Category> categories;
  final double centerSpaceRadius;
  final double baseSectionRadius;

  void _onChangeSelection(
    BuildContext context,
    PieTouchResponse? response,
  ) {
    final touchedSectionIndex = response?.touchedSection?.touchedSectionIndex;

    // If 'remaining' pie is tapped, do nothing
    if (touchedSectionIndex == categories.length) return;

    context
        .read<BudgetBreakdownViewModel>()
        .changeSelection(touchedSectionIndex ?? -1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBreakdownViewModel, BudgetBreakdownState>(
      builder: (context, state) {
        return PieChart(
          curve: Curves.easeInOutCubic,
          duration: const Duration(milliseconds: 400),
          PieChartData(
            sectionsSpace: _kSectionGap,
            centerSpaceRadius: centerSpaceRadius,
            startDegreeOffset: -90,
            pieTouchData: PieTouchData(
              enabled: true,
              touchCallback: (_, response) => _onChangeSelection(
                context,
                response,
              ),
            ),
            sections: BudgetUsageDisplayHelper.categoryToPieData(
              budget: budget,
              expense: expense,
              categories: categories,
              selectedIndex: state.selectedIndex,
              showRemaining: state.showRemaining,
              baseSectionRadius: baseSectionRadius,
            ),
          ),
        );
      },
    );
  }
}
