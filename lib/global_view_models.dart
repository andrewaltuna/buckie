import 'package:expense_tracker/feature/account/data/di/auth_service_locator.dart';
import 'package:expense_tracker/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:expense_tracker/feature/categories/presentation/view_model/categories_view_model.dart';
import 'package:expense_tracker/feature/transactions/presentation/view_model/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalViewModels extends StatelessWidget {
  const GlobalViewModels({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthViewModel(authRepository),
        ),
        BlocProvider(
          create: (_) => CategoriesViewModel()..add(CategoriesLoaded()),
        ),
        BlocProvider(
          create: (_) => TransactionsViewModel(),
        ),
      ],
      child: child,
    );
  }
}
