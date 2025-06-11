import 'package:expense_tracker/feature/categories/data/model/budget_category.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/dashboard/presentation/helper/budget_usage_display_helper.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/budget_breakdown_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _sectionSpacing = 2.0;

class BudgetBreakdownChart extends StatelessWidget {
  const BudgetBreakdownChart({
    super.key,
    required this.categories,
    required this.totalBudget,
    this.label,
    this.centerSpaceRadius = 50,
  });

  final String? label;
  final List<BudgetCategory> categories;
  final double totalBudget;
  final double centerSpaceRadius;

  @override
  Widget build(BuildContext context) {
    final labelSize = (centerSpaceRadius - _sectionSpacing) * 2;

    return BlocBuilder<BudgetBreakdownViewModel, BudgetBreakdownState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: labelSize,
              width: labelSize,
              child: Center(
                child: Text(
                  label ??
                      BudgetUsageDisplayHelper.percentageUsedDisplay(
                        categories: categories,
                        totalBudget: totalBudget,
                      ),
                  style: TextStyles.title.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            PieChart(
              swapAnimationCurve: Curves.easeOut,
              swapAnimationDuration: const Duration(milliseconds: 300),
              PieChartData(
                pieTouchData: PieTouchData(
                  enabled: true,
                  touchCallback: (event, response) {
                    final touchedSectionIndex =
                        response?.touchedSection?.touchedSectionIndex;

                    // If 'remaining' pie is tapped, do nothing
                    if (touchedSectionIndex == categories.length) return;

                    context
                        .read<BudgetBreakdownViewModel>()
                        .changeSelection(touchedSectionIndex ?? -1);
                  },
                ),
                sectionsSpace: _sectionSpacing,
                centerSpaceRadius: centerSpaceRadius,
                startDegreeOffset: -90,
                sections:
                    BudgetUsageDisplayHelper.categoryToPieChartSectionData(
                  categories: categories,
                  selectedIndex: state.selectedIndex,
                  totalBudget: totalBudget,
                  showRemaining: state.showRemaining,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
