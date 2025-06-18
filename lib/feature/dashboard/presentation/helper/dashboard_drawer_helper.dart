import 'package:expense_tracker/feature/categories/data/model/transaction_category.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:flutter/material.dart';

class DashboardDrawerHelper {
  static const percentageMaxHeight = 0.95;

  static const percentageMinHeight = 0.55;

  static const percentageMinHeightWithAllowance = percentageMinHeight - 0.1;

  static const percentageHeightMidpoint =
      (percentageMaxHeight + percentageMinHeight) / 2;

  static bool exceedsConstraints(double size) {
    return size > 1 || size < percentageMinHeightWithAllowance;
  }

  static List<TransactionCategory> generatePlaceholderCategories(int count) {
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
      AppColors.categoryYellow,
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

      return TransactionCategory(
        label: categories.first,
        icon: icons.first,
        color: colors.first,
        transactions: Transaction.generatePlaceholderTransactions(10),
        budget: 2000,
      );
    });
  }
}
