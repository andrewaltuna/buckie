import 'package:expense_tracker/common/extension/date_time.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transaction_group_card.dart';
import 'package:expense_tracker/feature/transactions/presentation/helper/transactions_helper.dart';
import 'package:flutter/material.dart';

class TransactionsListView extends StatelessWidget {
  const TransactionsListView({
    required this.transactionsByDate,
    super.key,
  });

  final Map<DateTime, List<Transaction>> transactionsByDate;

  void _onTap(
    BuildContext context,
    Transaction transaction,
  ) {
    TransactionsHelper.of(context).showTransactionDetailsModal(transaction);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: transactionsByDate.entries.map(
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
                    onTransactionTapped: (trx) => _onTap(context, trx),
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
