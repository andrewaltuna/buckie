import 'package:expense_tracker/categories/blocs/categories_bloc.dart';
import 'package:expense_tracker/transactions/blocs/transactions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBlocs extends StatelessWidget {
  const GlobalBlocs({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CategoriesBloc()..add(CategoriesLoaded()),
        ),
        BlocProvider(
          create: (_) => TransactionsBloc(),
        ),
      ],
      child: child,
    );
  }
}
