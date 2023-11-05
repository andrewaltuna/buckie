import 'package:expense_tracker/dashboard/components/budget_usage_indicator.dart';
import 'package:flutter/material.dart';

class BudgetUsageCard extends StatelessWidget {
  const BudgetUsageCard({
    super.key,
    this.height = 200,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BudgetUsageIndicator(
            color: Colors.blueGrey,
            size: 120,
            strokeWidth: 30,
            value: 0.6,
          ),
        ],
      ),
    );
  }
}
