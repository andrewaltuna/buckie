import 'package:expense_tracker/common/extension/date_time.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/transaction_group_card.dart';
import 'package:expense_tracker/feature/transactions/presentation/helper/transaction_helper.dart';
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
    TransactionHelper.of(context).showTransactionDetailsModal(transaction);
  }

  @override
  Widget build(BuildContext context) {
    final entries = transactionsByDate.entries;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries.elementAt(index);
        final date = entry.key;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 45,
                margin: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    Text(
                      date.dayOfWeek(shortened: true).toUpperCase(),
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                    Text(
                      Formatter.date(
                        date,
                        includeMonth: false,
                        includeYear: false,
                      ),
                      style: AppTextStyles.titleLarge,
                    ),
                  ],
                ),
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
    );
  }
}
