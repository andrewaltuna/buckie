import 'package:collection/collection.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/budget_breakdown_info_badge.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BudgetUsageDisplayHelper {
  const BudgetUsageDisplayHelper._();

  static const _selectedRadiusScale = 1.15;
  static const _remainingRadiusScale = 0.85;

  static String percentageUsedDisplay({
    required double expense,
    required double budget,
  }) {
    if (budget <= 0) return 'N/A';

    final percentage = expense / budget;

    return Formatter.percentage(percentage);
  }

  static List<PieChartSectionData> categoryToPieData({
    required double budget,
    required double expense,
    required List<Category> categories,
    required int selectedIndex,
    required bool showRemaining,
    required double baseSectionRadius,
  }) {
    final pieData = categories.mapIndexed((index, category) {
      final isSelected = index == selectedIndex;
      final percentage = category.expense / (showRemaining ? budget : expense);

      final expenseLabel = Formatter.currency(category.expense);
      final percentageLabel = Formatter.percentage(percentage);

      return PieChartSectionData(
        showTitle: false,
        value: category.expense,
        color: category.type.color,
        radius: isSelected
            ? baseSectionRadius * _selectedRadiusScale
            : baseSectionRadius,
        badgeWidget: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: SizedBox(
            key: UniqueKey(),
            child: switch (selectedIndex != -1) {
              true => isSelected
                  ? BudgetBreakdownInfoBadge(
                      label: category.type.label,
                      info: '$expenseLabel ($percentageLabel)',
                    )
                  : null,
              false => Icon(
                  category.type.icon,
                  color: AppColors.fontPrimary,
                ),
            },
          ),
        ),
      );
    }).toList();

    final remainingBalance = budget - expense;

    pieData.add(
      PieChartSectionData(
        title: 'Remaining',
        showTitle: false,
        value: showRemaining && remainingBalance > 0
            ? remainingBalance
            : 0.01, // Workaround to show animation on show/hide
        color: AppColors.widgetBackgroundSecondary,
        radius: baseSectionRadius * _remainingRadiusScale,
      ),
    );

    return pieData;
  }
}
