import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/transactions/data/model/transaction.dart';
import 'package:flutter/material.dart';

class BudgetCategory extends Equatable {
  const BudgetCategory({
    required this.label,
    required this.icon,
    required this.color,
    required this.transactions,
    required this.budget,
  });

  final String label;
  final IconData icon;
  final List<Transaction> transactions;
  final Color color;
  final double budget;

  static const empty = BudgetCategory(
    label: '',
    icon: Icons.category,
    color: Colors.transparent,
    transactions: [],
    budget: 0,
  );

  double get balance {
    return transactions.fold(0, (previousValue, transaction) {
      return previousValue + transaction.value;
    });
  }

  double get income {
    return transactions.fold(0, (previousValue, transaction) {
      if (transaction.value <= 0) {
        return previousValue;
      }

      return previousValue + transaction.value;
    });
  }

  double get expense {
    return transactions.fold(0, (previousValue, transaction) {
      if (transaction.value >= 0) {
        return previousValue;
      }

      return previousValue + transaction.value;
    });
  }

  String get balanceDisplay => Formatter.formatNum(balance);
  String get incomeDisplay => Formatter.formatNum(income);
  String get expenseDisplay => Formatter.formatNum(expense);

  double get percentageSpent => balance / budget;

  bool get isWithinBudget => percentageSpent <= 1;

  String get percentageSpentDisplay =>
      '${Formatter.formatNum(percentageSpent * 100)}%';

  double get amountRemaining => budget - balance;

  // String get amountRemainingDisplay => Formatter.formatNum(budget - balance);

  @override
  List<Object?> get props => [
        label,
        color,
        icon,
        transactions,
        budget,
      ];
}
