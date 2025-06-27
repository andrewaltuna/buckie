import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/budget/presentation/view_model/budgets_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/set_budget_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      // padding: const EdgeInsets.only(left: 6, right: 12),
      color: AppColors.accent,
      onTap: () => month != null
          ? ModalHelper.of(context).showModal(
              wrapperBuilder: (child) => BlocProvider.value(
                value: BlocProvider.of<BudgetsViewModel>(context),
                child: child,
              ),
              builder: (_) => SetBudgetModalContent(
                initialValue: budget,
                month: month!,
              ),
            )
          : null,
      child: const Icon(
        Icons.settings,
        color: AppColors.fontButtonPrimary,
      ),
    );
  }
}
