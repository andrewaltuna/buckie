import 'package:expense_tracker/feature/budget/presentation/view_model/budgets_view_model.dart';
import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/budget_breakdown_display.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/dashboard_drawer.dart';
import 'package:expense_tracker/feature/dashboard/presentation/helper/dashboard_drawer_helper.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/budget_breakdown_view_model.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/dashboard_drawer_view_model.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/model/extension/transaction.dart';
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
        body: _Content(),
      ),
    );
  }
}

class _Content extends HookWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final trxState = context.watch<TransactionsViewModel>().state;
    final month = context.watch<DashboardViewModel>().state;
    final monthKey = month?.key ?? '';
    final budgetsState = context.watch<BudgetsViewModel>().state;
    final budget = budgetsState.budgetOf(monthKey) ?? 0;
    final categories = trxState.toCategories(month?.key ?? '');
    final expense = trxState.transactionsOf(monthKey)?.sumAmount() ?? 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final budgetDisplayHeight = constraints.maxHeight *
            (1 - DashboardDrawerHelper.percentageMinHeight);

        return SizedBox.expand(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              BlocProvider(
                create: (_) => BudgetBreakdownViewModel(),
                child: BudgetBreakdownDisplay(
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
                  constraints: constraints,
                  categories: categories,
                  expense: expense,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Overlay extends StatelessWidget {
  const _Overlay();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardDrawerViewModel, DashboardDrawerState>(
      builder: (_, state) {
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
