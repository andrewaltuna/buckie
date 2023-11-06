import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/dashboard/components/budget_usage_indicator.dart';
import 'package:flutter/material.dart';

class BudgetUsageDisplay extends StatelessWidget {
  const BudgetUsageDisplay({
    super.key,
    this.height = 200,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                _ValueLabel(label: 'Spent', value: r'$3,000'),
                SizedBox(width: 15),
                _ValueLabel(label: 'Total', value: r'$5,000'),
              ],
            ),
          ),
          SizedBox(height: 30),
          BudgetUsageIndicator(
            color: Colors.blueGrey,
            size: 120,
            strokeWidth: 40,
            value: 0.6,
          ),
        ],
      ),
    );
  }
}

class _ValueLabel extends StatelessWidget {
  const _ValueLabel({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.fontFamilySecondary,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
