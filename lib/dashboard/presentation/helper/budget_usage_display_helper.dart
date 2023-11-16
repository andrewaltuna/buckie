import 'package:collection/collection.dart';
import 'package:expense_tracker/categories/data/model/budget_category.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/dashboard/presentation/component/budget_breakdown_info_badge.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BudgetUsageDisplayHelper {
  const BudgetUsageDisplayHelper._();

  /// Workaround for zero values not animating in the pie chart
  static const _pieSectionZeroValue = 0.00000001;

  static const _pieSectionRadius = 60.0;
  static const _pieSectionSelectedRadius = _pieSectionRadius * 1.15;
  static const _pieSectionRemainingRadius = _pieSectionRadius * 0.85;

  static double computeTotalAmountSpent(
    List<BudgetCategory> categories,
  ) {
    double totalAmountSpent = 0;
    for (final category in categories) {
      totalAmountSpent += category.balance;
    }

    return totalAmountSpent;
  }

  static String percentageUsedDisplay({
    required List<BudgetCategory> categories,
    required double totalBudget,
  }) {
    final totalAmountSpent = computeTotalAmountSpent(categories);
    final percentage = (totalAmountSpent / totalBudget) * 100;

    return '${percentage.toStringAsFixed(2)}%';
  }

  static String toPercentageDisplay(double value) {
    return '${(value * 100).toStringAsFixed(2)}%';
  }

  static List<PieChartSectionData> categoryToPieChartSectionData({
    required double totalBudget,
    required List<BudgetCategory> categories,
    required int selectedIndex,
    required bool showRemaining,
  }) {
    final totalAmountSpent = computeTotalAmountSpent(categories);

    final pieChartData = categories.mapIndexed((index, category) {
      final key = UniqueKey();
      final hasSelection = selectedIndex != -1;
      final isSelected = index == selectedIndex;
      final percentageText = toPercentageDisplay(
        category.balance / (showRemaining ? totalBudget : totalAmountSpent),
      );

      final badge = switch (isSelected) {
        true => BudgetBreakdownInfoBadge(
            key: key,
            label: category.label,
            info: '${category.balanceDisplay} ($percentageText)',
          ),
        false => hasSelection
            ? null
            : Icon(
                key: key,
                category.icon,
                color: Colors.white,
              ),
      };

      return PieChartSectionData(
        showTitle: false,
        value: category.balance,
        badgeWidget: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: badge,
        ),
        color: category.color,
        radius: isSelected ? _pieSectionSelectedRadius : _pieSectionRadius,
      );
    }).toList();

    pieChartData.add(
      PieChartSectionData(
        title: 'Remaining',
        showTitle: false,
        value: showRemaining && totalAmountSpent < totalBudget
            ? totalBudget - totalAmountSpent
            : _pieSectionZeroValue,
        color: AppColors.widgetBackgroundSecondary,
        radius: _pieSectionRemainingRadius,
      ),
    );

    return pieChartData;
  }
}
