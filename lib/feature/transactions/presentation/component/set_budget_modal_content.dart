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

  void _onUsePreviousBudget(
    BuildContext context,
    TextEditingController controller,
  ) {
    final viewModel = context.read<BudgetsViewModel>();
    final latestBudget = viewModel.state.latestBudget;

    if (latestBudget != null) {
      controller.text = latestBudget.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialValue = this.initialValue != null && this.initialValue! > 0
        ? this.initialValue
        : null;
    final focusNode = useFocusNode();
    final controller = useTextEditingController(
      text: initialValue?.toString(),
    );

    useEffect(
      () {
        focusNode.requestFocus();

        return;
      },
      [],
    );

    return ModalBase(
      header: Row(
        children: [
          const Text(
            'Configure Budget',
            style: TextStyles.titleRegular,
          ),
          const Spacer(),
          _IconButton(
            icon: Icons.undo,
            primary: false,
            onTap: () => _onUsePreviousBudget(context, controller),
          ),
          const SizedBox(width: 8),
          _IconButton(
            icon: Icons.check,
            onTap: () => _onSubmit(context, controller),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RoundedTextField(
            controller: controller,
            focusNode: focusNode,
            label: 'Amount',
            allowClear: true,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            inputFormatters: [
              InputFormatter.decimal,
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onTap,
    this.primary = true,
  });

  final VoidCallback? onTap;
  final IconData icon;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      width: 36,
      height: 36,
      borderRadius: 12,
      color: primary ? AppColors.accent : AppColors.widgetBackgroundPrimary,
      onTap: onTap,
      child: Icon(
        icon,
        color: primary
            ? AppColors.fontButtonPrimary
            : AppColors.fontButtonSecondary,
      ),
    );
  }
}
