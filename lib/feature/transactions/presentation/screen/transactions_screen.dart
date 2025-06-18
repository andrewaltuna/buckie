import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/di/service_locator.dart';
import 'package:expense_tracker/common/extension/date_time.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/category_display.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transaction_group_card.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transaction_preview_skeleton.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transactions_empty_indicator.dart';
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
              transactions: state.byDate(),
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
    required this.transactions,
    required this.isLoading,
  });

  final Map<DateTime, List<Transaction>> transactions;
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

    if (transactions.isEmpty) {
      return const Center(
        child: TransactionsEmptyIndicator(),
      );
    }

    return ListView(
      children: transactions.entries.map(
        (entry) {
          final date = entry.key;

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      Formatter.date(date, includeYear: false),
                      style: TextStyles.titleExtraSmall,
                    ),
                    Text(
                      date.dayOfWeek(shortened: true).toUpperCase(),
                      style: TextStyles.titleSmall.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TransactionGroupCard(
                    transactions: entry.value,
                    onTransactionTapped: (trx) =>
                        ModalHelper.of(context).showModal(
                      headerBuilder: (context) {
                        return Row(
                          children: [
                            CategoryDisplay(
                              height: 36,
                              width: 36,
                              category: trx.category,
                              iconOnly: true,
                              iconSize: 20,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trx.category.label,
                                  style: TextStyles.titleSmall,
                                ),
                                Text(
                                  Formatter.date(trx.date),
                                  style: TextStyles.bodySmall.copyWith(
                                    color: AppColors.fontSubtitle,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            CustomInkWell(
                              width: 36,
                              height: 36,
                              borderRadius: 12,
                              color: AppColors.accent,
                              onTap: () => {},
                              child: const Icon(
                                Icons.edit,
                                color: AppColors.fontButtonPrimary,
                              ),
                            ),
                          ],
                        );
                      },
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Amount',
                              style: TextStyles.titleExtraSmall.copyWith(
                                color: AppColors.fontPrimary,
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    Formatter.currency(trx.amount),
                                    style: TextStyles.bodyRegular.copyWith(
                                      color: AppColors.fontSubtitle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Remarks',
                              style: TextStyles.titleExtraSmall.copyWith(
                                color: AppColors.fontPrimary,
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    trx.remarks ?? 'No remarks',
                                    style: TextStyles.bodyRegular.copyWith(
                                      color: AppColors.fontSubtitle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
