import 'package:expense_tracker/feature/budget/presentation/view_model/budgets_view_model.dart';
import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/budget_breakdown_view.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/budgeting_tooltip.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/dashboard_drawer.dart';
import 'package:expense_tracker/feature/dashboard/presentation/helper/dashboard_drawer_helper.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/budget_breakdown_view_model.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/dashboard_drawer_view_model.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/extension/transaction_extension.dart';
import 'package:expense_tracker/feature/transactions/presentation/view_model/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const routeName = 'dashboard';
  static const routePath = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardDrawerViewModel(),
      child: const MainScaffold(
        title: 'Overview',
        titleWidget: Padding(
          padding: EdgeInsets.only(top: 4),
          child: BudgetingTooltip(),
        ),
        resizeToAvoidBottomInset: false,
        body: _Content(),
      ),
    );
  }
}

class _Content extends HookWidget {
  const _Content();

  void _onMonthUpdated(
    BuildContext context,
    TransactionMonth month,
  ) {
    context.read<TransactionsViewModel>().add(
          TransactionsRequested(month: month),
        );
  }

  @override
  Widget build(BuildContext context) {
    final month = context.watch<DashboardViewModel>().state;
    final monthKey = month?.key ?? '';

    final budget = context.select(
      (BudgetsViewModel vm) => vm.state.budgetOf(monthKey) ?? 0,
    );

    final (
      recentTransactions,
      categories,
      expense,
    ) = context.select(
      (TransactionsViewModel vm) => (
        vm.state.recentTransactions,
        vm.state.toCategories(monthKey),
        vm.state.transactionsOf(monthKey)?.sumAmount() ?? 0,
      ),
    );

    return BlocListener<DashboardViewModel, TransactionMonth?>(
      listenWhen: (_, current) => current != null,
      listener: (context, month) => _onMonthUpdated(context, month!),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final budgetDisplayHeight = constraints.maxHeight *
              (1 - DashboardDrawerHelper.percentMinHeight);

          return Stack(
            alignment: Alignment.topCenter,
            children: [
              BlocProvider(
                create: (_) => BudgetBreakdownViewModel(),
                child: BudgetBreakdownView(
                  month: month,
                  height: budgetDisplayHeight,
                  budget: budget,
                  expense: expense,
                  categories: categories,
                ),
              ),
              const Positioned.fill(
                child: _Overlay(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: DashboardDrawer(
                  maxHeight: constraints.maxHeight,
                  categories: categories,
                  transactions: recentTransactions,
                  expense: expense,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Overlay extends StatelessWidget {
  const _Overlay();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardDrawerViewModel, DashboardDrawerState>(
      builder: (context, state) {
        return IgnorePointer(
          child: Container(
            color: Colors.black.withValues(
              alpha: state.overlayOpacity,
            ),
          ),
        );
      },
    );
  }
}
