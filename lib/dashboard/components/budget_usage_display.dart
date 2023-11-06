import 'package:expense_tracker/categories/models/budget_category.dart';
import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/dashboard/blocs/budget_usage_display_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetUsageDisplay extends StatelessWidget {
  const BudgetUsageDisplay({
    super.key,
    required this.totalBudget,
    required this.categories,
    this.height = 200,
  });

  final double totalBudget;
  final List<BudgetCategory> categories;
  final double height;

  List<PieChartSectionData> _categoryToPieChartSectionData(
    List<BudgetCategory> categories,
  ) {
    double totalAmountSpent = 0;
    for (final category in categories) {
      totalAmountSpent += category.amountSpent;
    }

    return categories
        .map((category) => PieChartSectionData(
              title: category.label,
              value: category.amountSpent,
              badgeWidget: Icon(category.icon),
              color: category.color,
              showTitle: false,
              radius: 60,
            ))
        .toList()
      // Fill remainder with Remaining budget
      ..add(PieChartSectionData(
        title: 'Remaining',
        showTitle: false,
        value: totalBudget - totalAmountSpent,
        color: Colors.black.withOpacity(0.5),
        radius: 60,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                _ValueLabel(label: 'Spent', value: '${r'$'}3,000'),
                SizedBox(width: 15),
                _ValueLabel(label: 'Total', value: '${r'$'}5,000'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    enabled: true,
                    touchCallback: (event, response) {
                      final noSelection = !event.isInterestedForInteractions ||
                          response == null ||
                          response.touchedSection == null;

                      context.read<BudgetUsageDisplayCubit>().changeSelection(
                            noSelection
                                ? -1
                                : response.touchedSection!.touchedSectionIndex,
                          );
                    },
                  ),
                  sectionsSpace: 2,
                  centerSpaceRadius: double.infinity,
                  startDegreeOffset: -90,
                  sections: _categoryToPieChartSectionData(categories),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueLabel extends StatelessWidget {
  const _ValueLabel({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.fontFamilySecondary,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
