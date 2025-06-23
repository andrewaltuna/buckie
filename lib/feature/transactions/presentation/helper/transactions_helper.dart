import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transaction_detail_modal_content.dart';
import 'package:expense_tracker/feature/transactions/presentation/view_model/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsHelper {
  const TransactionsHelper._(this._context);

  factory TransactionsHelper.of(BuildContext context) =>
      TransactionsHelper._(context);

  final BuildContext _context;

  void showTransactionDetailsModal(
    Transaction transaction, {
    bool allowEditting = true,
  }) {
    ModalHelper.of(_context).showModal(
      wrapperBuilder: (child) => BlocProvider.value(
        value: BlocProvider.of<TransactionsViewModel>(_context),
        child: child,
      ),
      builder: (_) => TransactionDetailModalContent(
        transaction: transaction,
        allowEditting: allowEditting,
      ),
    );
  }
}
