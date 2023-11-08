import 'dart:math';

import 'package:expense_tracker/categories/models/budget_category.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DashboardDrawerHelper {
  static const percentageMaxHeight = 0.95;

  static const percentageMinHeight = 0.5;

  static const percentageMinHeightWithAllowance = percentageMinHeight - 0.15;

  static const percentageHeightMidpoint =
      (percentageMaxHeight + percentageMinHeight) / 2;

  static bool isBetween(double size) {
    return size > 1 || size < percentageMinHeightWithAllowance;
  }

  static List<BudgetCategory> generatePlaceholderCategories(int count) {
    final categories = [
      'Transport',
      'Food',
      'Shopping',
      'Bills',
      'Others',
    ];
    final colors = [
      AppColors.categoryBlue,
      AppColors.categoryOrange,
      AppColors.categoryMagenta,
      AppColors.categoryPurple,
      // AppColors.categoryYellow,
    ];
    final icons = [
      Icons.house,
      Icons.fastfood,
      Icons.shopping_bag,
      Icons.receipt,
      Icons.car_rental,
    ];
    return List.generate(count, (_) {
      categories.shuffle();
      colors.shuffle();
      icons.shuffle();

      return BudgetCategory(
        label: categories.first,
        icon: icons.first,
        color: colors.first,
        allottedBudget: 1000,
        amountSpent: Random().nextInt(1000).toDouble(),
      );
    });
  }
}
