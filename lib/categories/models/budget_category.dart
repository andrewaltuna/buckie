import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BudgetCategory extends Equatable {
  const BudgetCategory({
    required this.label,
    required this.icon,
    required this.color,
    required this.allottedBudget,
    required this.amountSpent,
  });

  final String label;
  final IconData icon;
  // TODO: transactions list
  final Color color;
  final double allottedBudget;
  final double amountSpent; // TODO: turn into getter; value from trx list

  static const empty = BudgetCategory(
    label: '',
    icon: Icons.category,
    color: Colors.transparent,
    allottedBudget: 0,
    amountSpent: 0,
  );
  double get percentageSpent => amountSpent / allottedBudget;
  String get percentageSpentDisplay =>
      (percentageSpent * 100).toStringAsFixed(2);
  String get amountRemainingDisplay =>
      (allottedBudget - amountSpent).toStringAsFixed(2);

  @override
  List<Object?> get props => [
        label,
        color,
        icon,
        allottedBudget,
        amountSpent,
      ];
}
