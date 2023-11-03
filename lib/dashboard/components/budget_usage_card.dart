import 'package:expense_tracker/dashboard/components/budget_usage_indicator.dart';
import 'package:flutter/material.dart';

class BudgetUsageCard extends StatelessWidget {
  const BudgetUsageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.lightGreen.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
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
