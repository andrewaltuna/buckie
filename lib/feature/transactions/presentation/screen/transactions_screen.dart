import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/di/service_locator.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
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
    final currentDate = DateTime.now();

    return MainScaffold(
      title: 'Transactions',
      body: PageView.builder(
        controller: controller,
        onPageChanged: (value) => page.value = value,
        itemBuilder: (context, index) {
          final offset = index - _kInitialPage;
          final month = TransactionMonth(
            month: currentDate.month + offset,
            year: currentDate.year,
          );

          if (page.value - index >= 3) {
            return const SizedBox.shrink();
          }
          return BlocProvider(
            create: (_) => TransactionsViewModel(
              sl<TransactionRepositoryInterface>(),
              month: month,
            )..add(const TransactionsRequested()),
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

    final state = context.watch<TransactionsViewModel>().state;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  Formatter.date(month.toDate(), includeDay: false),
                  style: TextStyles.titleMedium,
                ),
              ),
              Text(
                '${state.totalExpenseLabel} of ${Formatter.currency(10000)}',
                style: TextStyles.titleSmall.copyWith(
                  color: AppColors.fontWarning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _TransactionsList(
              transactionsByDate: state.byDate(),
              isLoading: state.status.isLoading,
            ),
          ),
        ],
      ),
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
