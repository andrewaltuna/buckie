import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/di/service_locator.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/create_transaction_form.dart';
import 'package:expense_tracker/feature/transactions/presentation/screen/transactions_screen.dart';
import 'package:expense_tracker/feature/transactions/presentation/view_model/create_transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTransactionScreen extends StatelessWidget {
  const CreateTransactionScreen({super.key});

  static const routeName = 'Create Transaction';
  static const routePath = '${TransactionsScreen.routePath}/create';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateTransactionViewModel(
        sl<TransactionRepositoryInterface>(),
      ),
      child: const MainScaffold(
        title: 'Create Transaction',
        showNavBar: false,
        showBackButton: true,
        body: CreateTransactionForm(),
      ),
    );
  }
}
