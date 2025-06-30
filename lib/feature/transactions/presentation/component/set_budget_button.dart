import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/budget/presentation/helper/budget_helper.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:flutter/material.dart';

class SetBudgetButton extends StatelessWidget {
  const SetBudgetButton({
    required this.month,
    this.budget,
    this.hasLabel = false,
    super.key,
  });

  final TransactionMonth? month;
  final double? budget;
  final bool hasLabel;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      width: 32,
      height: 32,
      borderRadius: 8,
      color: AppColors.accent,
      onTap: () => month != null
          ? BudgetHelper.of(context).showSetBudgetModal(
              initialValue: budget,
              month: month!,
            )
          : null,
      child: const Icon(
        Icons.settings,
        color: AppColors.fontButtonPrimary,
      ),
    );
  }
}
