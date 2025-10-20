import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/feature/budget/presentation/view_model/budgets_view_model.dart';
import 'package:expense_tracker/feature/categories/presentation/view_model/categories_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transaction_detail_modal_content.dart';
import 'package:expense_tracker/feature/transactions/presentation/view_model/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionHelper {
  const TransactionHelper._(this._context);

  factory TransactionHelper.of(BuildContext context) =>
      TransactionHelper._(context);

  final BuildContext _context;

  void showTransactionDetailsModal(
    Transaction transaction, {
    bool allowEditing = true,
  }) {
    ModalHelper.of(_context).showModal(
      wrapperBuilder: (child) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: BlocProvider.of<TransactionsViewModel>(_context),
          ),
          BlocProvider.value(
            value: BlocProvider.of<CategoriesViewModel>(_context),
          ),
        ],
        child: child,
      ),
      builder: (_) => TransactionDetailModalContent(
        transaction: transaction,
        allowEditing: allowEditing,
      ),
    );
  }

  void fetchMonthData(TransactionMonth month) {
    _context.read<TransactionsViewModel>().add(
          TransactionsRequested(month: month),
        );
    _context.read<BudgetsViewModel>().add(BudgetsRequested(month));
  }
}
