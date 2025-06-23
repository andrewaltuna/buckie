import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/component/text_field/rounded_text_field.dart';
import 'package:expense_tracker/common/helper/input_formatter.dart';
import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/budget/presentation/view_model/budgets_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SetBudgetModalContent extends HookWidget {
  const SetBudgetModalContent({
    required this.month,
    this.initialValue,
    super.key,
  });

  final double? initialValue;
  final TransactionMonth month;

  void _onSubmit(
    BuildContext context,
    TextEditingController controller,
  ) {
    final amount = controller.text;
    final budget = double.tryParse(amount) ?? 0;

    context.read<BudgetsViewModel>().add(
          BudgetsSet(
            month,
            amount: budget,
          ),
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(
      text: initialValue?.toString(),
    );

    return ModalBase(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Set Budget',
            style: TextStyles.titleRegular,
          ),
          CustomInkWell(
            width: 36,
            height: 36,
            borderRadius: 12,
            color: AppColors.accent,
            onTap: () => _onSubmit(context, controller),
            child: const Icon(
              Icons.check,
              color: AppColors.fontButtonPrimary,
            ),
          ),
        ],
      ),
      body: RoundedTextField(
        controller: controller,
        label: 'Amount',
        keyboardType: TextInputType.number,
        inputFormatters: [
          InputFormatter.decimal,
        ],
      ),
    );
  }
}
