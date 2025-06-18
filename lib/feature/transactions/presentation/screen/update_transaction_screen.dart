import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/di/service_locator.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/create_transaction_form.dart';
import 'package:expense_tracker/feature/transactions/presentation/screen/transactions_screen.dart';
import 'package:expense_tracker/feature/transactions/presentation/view_model/create_transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTransactionScreen extends StatelessWidget {
  const UpdateTransactionScreen({
    required this.transaction,
    super.key,
  });

  static const routeName = 'Update Transaction';
  static const routePath =
      '${TransactionsScreen.routePath}/update-transaction/:id';

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateTransactionViewModel(
        sl<TransactionRepositoryInterface>(),
        transactionId: transaction.id,
      )
        ..add(CreateTransactionAmountUpdated(transaction.amount))
        ..add(CreateTransactionCategoryUpdated(transaction.category))
        ..add(CreateTransactionDateUpdated(transaction.date))
        ..add(CreateTransactionRemarksUpdated(transaction.remarks ?? '')),
      child: MainScaffold(
        title: 'Update Transaction',
        showNavBar: false,
        showBackButton: true,
        body: CreateTransactionForm(
          transaction: transaction,
        ),
      ),
    );
  }
}
