import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class BudgetBreakdownInfoBadge extends StatelessWidget {
  const BudgetBreakdownInfoBadge({
    super.key,
    required this.label,
    required this.info,
  });

  final String label;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyles.titleRegular,
          ),
          Text(
            info,
            style: TextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}
