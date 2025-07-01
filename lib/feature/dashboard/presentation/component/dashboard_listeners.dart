import 'package:expense_tracker/feature/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/presentation/helper/transaction_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardListeners extends StatelessWidget {
  const DashboardListeners({
    required this.child,
    super.key,
  });

  final Widget child;

  void _onMonthUpdated(
    BuildContext context,
    TransactionMonth month,
  ) {
    TransactionHelper.of(context).fetchMonthData(month);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardViewModel, TransactionMonth?>(
      listenWhen: (_, current) => current != null,
      listener: (context, month) => _onMonthUpdated(context, month!),
      child: child,
    );
  }
}
