import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:flutter/material.dart';

class TransactionCategory extends Equatable {
  const TransactionCategory({
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

  static const empty = TransactionCategory(
    label: '',
    icon: Icons.category,
    color: Colors.transparent,
    transactions: [],
    budget: 0,
  );

  double get balance {
    return transactions.fold(0, (previousValue, transaction) {
      return previousValue + transaction.amount;
    });
  }

  double get income {
    return transactions.fold(0, (previousValue, transaction) {
      if (transaction.amount <= 0) {
        return previousValue;
      }

      return previousValue + transaction.amount;
    });
  }

  double get expense {
    return transactions.fold(0, (previousValue, transaction) {
      if (transaction.amount >= 0) {
        return previousValue;
      }

      return previousValue + transaction.amount;
    });
  }

  String get balanceDisplay => Formatter.currency(balance);
  String get incomeDisplay => Formatter.currency(income);
  String get expenseDisplay => Formatter.currency(expense);

  double get percentageSpent => balance / budget;

  bool get isWithinBudget => percentageSpent <= 1;

  String get percentageSpentDisplay =>
      '${Formatter.currency(percentageSpent * 100)}%';

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

enum TransactionCategoryType {
  clothing('Clothing'),
  education('Education'),
  entertainment('Entertainment'),
  food('Food'),
  gift('Gift'),
  groceries('Groceries'),
  health('Health'),
  transport('Transport'),
  travel('Travel'),
  utilities('Utilities'),
  other('Other');

  const TransactionCategoryType(this.label);

  final String label;

  IconData get icon => switch (this) {
        TransactionCategoryType.clothing => Icons.checkroom,
        TransactionCategoryType.education => Icons.school,
        TransactionCategoryType.entertainment => Icons.movie,
        TransactionCategoryType.food => Icons.restaurant,
        TransactionCategoryType.gift => Icons.card_giftcard,
        TransactionCategoryType.groceries => Icons.shopping_cart,
        TransactionCategoryType.health => Icons.medical_services,
        TransactionCategoryType.transport => Icons.directions_car,
        TransactionCategoryType.travel => Icons.flight,
        TransactionCategoryType.utilities => Icons.build,
        TransactionCategoryType.other => Icons.more_horiz,
      };

  Color get color => switch (this) {
        TransactionCategoryType.clothing =>
          const Color(0xFFB667F1), // Vibrant Purple
        TransactionCategoryType.education =>
          const Color(0xFF4CC9F0), // Light Blue
        TransactionCategoryType.entertainment =>
          const Color(0xFFF72585), // Hot Pink
        TransactionCategoryType.food => const Color(0xFFFF9F1C), // Warm Orange
        TransactionCategoryType.gift => const Color(0xFFE63946), // Coral Red
        TransactionCategoryType.groceries =>
          const Color(0xFF2EC4B6), // Turquoise
        TransactionCategoryType.health => const Color(0xFFFF006B), // Deep Pink
        TransactionCategoryType.transport => const Color(0xFF00B4D8), // Cyan
        TransactionCategoryType.travel => const Color(0xFF06D6A0), // Mint
        TransactionCategoryType.utilities =>
          const Color(0xFF7D8597), // Steel Gray
        TransactionCategoryType.other => const Color(0xFF6B7280), // Cool Gray
      };
}
