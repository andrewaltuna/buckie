import 'package:expense_tracker/common/di/service_locator.dart';
import 'package:expense_tracker/feature/categories/presentation/view_model/categories_view_model.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CategoriesViewModel()..add(const CategoriesLoaded()),
        ),
        BlocProvider(
          create: (_) => TransactionsViewModel(
            sl<TransactionRepositoryInterface>(),
          )
            ..add(const TransactionsStreamInitialized())
            ..add(const TransactionsRequested()),
        ),
      ],
      child: child,
    );
  }
}
