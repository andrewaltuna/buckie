import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/di/service_locator.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/budget/data/repository/budget_repository_interface.dart';
import 'package:expense_tracker/feature/budget/presentation/view_model/budget_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/extension/transaction.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/set_budget_modal_content.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transaction_preview_skeleton.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transactions_empty_indicator.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transactions_list_view.dart';
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
      body: PageView.builder(
        controller: controller,
        onPageChanged: (value) => page.value = value,
        itemBuilder: (context, index) {
          final offset = index - _kInitialPage;
          final month = TransactionMonth.fromDate(
            currentDate.copyWith(month: currentDate.month + offset),
          );

          return MultiBlocProvider(
            providers: [
              // BlocProvider.value(
              //   value: BlocProvider.of<TransactionsViewModel>(context)
              //     ..add(TransactionsRequested(month)),
              // ),
              BlocProvider(
                create: (_) => BudgetViewModel(
                  sl<BudgetRepositoryInterface>(),
                  month: month,
                )..add(const BudgetRequested()),
              ),
            ],
            child: _TransactionsPage(month: month),
          );
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
        context.read<TransactionsViewModel>().add(TransactionsRequested(month));

        return;
      },
      [],
    );

    return BlocBuilder<TransactionsViewModel, TransactionsState>(
      builder: (context, state) {
        final transactions = state.transactionsByMonth[month.key] ?? [];
        final isLoading =
            state.status.isLoading && month.key == state.selectedMonth?.key;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    Formatter.date(
                      month.toDateTime(),
                      includeDay: false,
                    ),
                    style: TextStyles.titleMedium,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _BudgetIndicator(
                      expenseLabel: Formatter.currency(
                        transactions.sumAmount(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _TransactionsList(
                  transactionsByDate: transactions.byDate(),
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

class _BudgetIndicator extends StatelessWidget {
  const _BudgetIndicator({
    required this.expenseLabel,
  });

  final String expenseLabel;

  @override
  Widget build(BuildContext context) {
    final budget = context.select(
      (BudgetViewModel viewModel) => viewModel.state.amount,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // const Text(
                //   'Used ',
                //   style: TextStyles.titleExtraSmall,
                // ),
                Text(
                  expenseLabel,
                  style: TextStyles.titleSmall.copyWith(
                    color: AppColors.fontWarning,
                  ),
                ),
                if (budget != null) ...[
                  const Text(
                    ' of ',
                    style: TextStyles.titleExtraSmall,
                  ),
                  Text(
                    Formatter.currency(budget),
                    style: TextStyles.titleSmall.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        CustomInkWell(
          width: 32,
          height: 32,
          borderRadius: 8,
          color: AppColors.accent,
          onTap: () => ModalHelper.of(context).showModal(
            wrapperBuilder: (child) => BlocProvider.value(
              value: BlocProvider.of<BudgetViewModel>(context),
              child: child,
            ),
            builder: (_) => SetBudgetModalContent(
              initialValue: budget,
            ),
          ),
          child: const Icon(
            Icons.settings,
            color: AppColors.fontButtonPrimary,
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
      return const Center(
        child: TransactionsEmptyIndicator(),
      );
    }

    return TransactionsListView(
      transactionsByDate: transactionsByDate,
    );
  }
}
