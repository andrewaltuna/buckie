import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/feature/budget/presentation/view_model/budgets_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/set_budget_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetHelper {
  const BudgetHelper._(this._context);

  factory BudgetHelper.of(BuildContext context) => BudgetHelper._(context);

  final BuildContext _context;

  void showSetBudgetModal({
    required TransactionMonth month,
    double? initialValue,
  }) {
    ModalHelper.of(_context).showModal(
      wrapperBuilder: (child) => BlocProvider.value(
        value: BlocProvider.of<BudgetsViewModel>(_context),
        child: child,
      ),
      builder: (_) => SetBudgetModalContent(
        initialValue: initialValue,
        month: month,
      ),
    );
  }
}
