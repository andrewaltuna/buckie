import 'package:expense_tracker/common/di/service_locator.dart';
import 'package:expense_tracker/common/extension/date_time.dart';
import 'package:expense_tracker/feature/budget/data/repository/budget_repository_interface.dart';
import 'package:expense_tracker/feature/budget/presentation/view_model/budgets_view_model.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
import 'package:expense_tracker/feature/transactions/presentation/view_model/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticatedViewModels extends StatelessWidget {
  const AuthenticatedViewModels({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final currentMonth = DateTime.now().toTransactionMonth();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TransactionsViewModel(
            sl<TransactionRepositoryInterface>(),
          )
            ..add(const TransactionsStreamInitialized())
            ..add(
              TransactionsRequested(
                month: currentMonth,
                fetchRecents: true,
              ),
            ),
        ),
        BlocProvider(
          create: (_) => BudgetsViewModel(
            sl<BudgetRepositoryInterface>(),
          )
            ..add(const BudgetsLatestRequested())
            ..add(BudgetsRequested(currentMonth)),
        ),
        BlocProvider(
          create: (_) => DashboardViewModel()..selectMonth(currentMonth),
        ),
      ],
      child: child,
    );
  }
}
