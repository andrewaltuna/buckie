import 'package:equatable/equatable.dart';
import 'package:expense_tracker/transactions/models/transaction.dart';
import 'package:flutter/material.dart';

class BudgetCategory extends Equatable {
  const BudgetCategory({
    required this.label,
    required this.icon,
    required this.color,
    required this.transactions,
    required this.allottedBudget,
  });

  final String label;
  final IconData icon;
  final List<Transaction> transactions;
  final Color color;
  final double allottedBudget;

  static const empty = BudgetCategory(
    label: '',
    icon: Icons.category,
    color: Colors.transparent,
    transactions: [],
    allottedBudget: 0,
  );

  double get amountTotal {
    return transactions.fold(0, (previousValue, transaction) {
      return previousValue + transaction.value;
    });
  }

  double get incomeTotal {
    return transactions.fold(0, (previousValue, transaction) {
      if (transaction.value <= 0) {
        return previousValue;
      }

      return previousValue + transaction.value;
    });
  }

  double get expenseTotal {
    return transactions.fold(0, (previousValue, transaction) {
      if (transaction.value >= 0) {
        return previousValue;
      }

      return previousValue + transaction.value;
    });
  }

  double get percentageSpent => amountTotal / allottedBudget;

  String get percentageSpentDisplay {
    return (percentageSpent * 100).toStringAsFixed(2);
  }

  String get amountRemainingDisplay {
    return (allottedBudget - amountTotal).toStringAsFixed(2);
  }

  @override
  List<Object?> get props => [
        label,
        color,
        icon,
        transactions,
        allottedBudget,
      ];
}
