import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/extension/context.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/budget/presentation/view_model/budgets_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/extension/transaction_extension.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/set_budget_button.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transaction_preview_skeleton.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transactions_empty_indicator.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transactions_list_view.dart';
import 'package:expense_tracker/feature/transactions/presentation/helper/transaction_helper.dart';
import 'package:expense_tracker/feature/transactions/presentation/view_model/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _kInitialPage = 100000;

class TransactionsScreen extends HookWidget {
  const TransactionsScreen({super.key});

  static const routeName = 'transactions';
  static const routePath = '/transactions';

  @override
  Widget build(BuildContext context) {
    final controller = usePageController(initialPage: _kInitialPage);
    final page = useState(_kInitialPage);
    final currentDate = useMemoized(() => DateTime.now());

    return MainScaffold(
      title: 'Transactions',
      resizeToAvoidBottomInset: false,
      body: PageView.builder(
        controller: controller,
        onPageChanged: (value) => page.value = value,
        itemBuilder: (context, index) {
          final offset = index - _kInitialPage;
          final month = TransactionMonth.fromDate(
            currentDate.copyWith(month: currentDate.month + offset),
          );

          return _TransactionsPage(month: month);
        },
      ),
    );
  }
}

class _TransactionsPage extends HookWidget {
  const _TransactionsPage({
    required this.month,
  });

  final TransactionMonth month;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    useEffect(
      () {
        TransactionHelper.of(context).fetchMonthData(month);

        return;
      },
      [],
    );

    return BlocBuilder<TransactionsViewModel, TransactionsState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.transactionsOf(month.key) !=
              current.transactionsOf(month.key),
      builder: (context, state) {
        final transactions = state.transactionsOf(month.key);
        final isLoading = state.status.isLoading && transactions == null;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                month: month,
                expenseLabel: Formatter.currency(
                  transactions?.sumAmount() ?? 0,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _TransactionsList(
                  transactionsByDate: transactions?.byDate() ?? const {},
                  isLoading: isLoading,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.expenseLabel,
    required this.month,
  });

  final String expenseLabel;
  final TransactionMonth month;

  @override
  Widget build(BuildContext context) {
    final budget = context.select(
      (BudgetsViewModel vm) => vm.state.budgetOf(month.key),
    );

    return Row(
      children: [
        Text(
          Formatter.date(
            month.toDateTime(),
            includeDay: false,
          ),
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.widgetBackgroundSecondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          expenseLabel,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.fontWarning,
                          ),
                        ),
                        if (budget != null && budget > 0) ...[
                          const Text(
                            ' of ',
                            style: AppTextStyles.titleExtraSmall,
                          ),
                          Text(
                            Formatter.currency(budget),
                            style: AppTextStyles.titleSmall.copyWith(
                              color: AppColors.accent,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SetBudgetButton(
                budget: budget,
                month: month,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TransactionsList extends StatelessWidget {
  const _TransactionsList({
    required this.transactionsByDate,
    required this.isLoading,
  });

  final Map<DateTime, List<Transaction>> transactionsByDate;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ListView.separated(
        itemCount: 4,
        itemBuilder: (_, index) => const TransactionPreviewSkeleton(),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      );
    }

    if (transactionsByDate.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: context.padding.bottom),
          child: const TransactionsEmptyIndicator(),
        ),
      );
    }

    return TransactionsListView(
      transactionsByDate: transactionsByDate,
    );
  }
}
