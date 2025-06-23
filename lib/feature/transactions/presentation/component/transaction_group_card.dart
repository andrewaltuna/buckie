import 'package:collection/collection.dart';
import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/extension/transaction.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/category_icon.dart';
import 'package:flutter/material.dart';

/// Displays a set of transactions grouped by date
class TransactionGroupCard extends StatelessWidget {
  const TransactionGroupCard({
    required this.transactions,
    this.onTransactionTapped,
    super.key,
  });

  final List<Transaction> transactions;
  final void Function(Transaction)? onTransactionTapped;

  @override
  Widget build(BuildContext context) {
    final amount = Formatter.currency(transactions.sumAmount());

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            color: AppColors.widgetBackgroundSecondary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Total  ',
                  style: TextStyles.titleExtraSmall,
                ),
                Text(
                  amount,
                  style: TextStyles.titleSmall.copyWith(
                    color: AppColors.fontWarning,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: transactions
                .mapIndexed(
                  (index, trx) => _TransactionRow(
                    transaction: trx,
                    color: index.isEven
                        ? AppColors.tableRow
                        : AppColors.tableRowAlt,
                    onTap: onTransactionTapped,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({
    required this.transaction,
    required this.color,
    this.onTap,
  });

  final Transaction transaction;
  final Color color;
  final void Function(Transaction)? onTap;

  @override
  Widget build(BuildContext context) {
    final amount = Formatter.currency(transaction.amount);

    return CustomInkWell(
      color: color,
      onTap: () => onTap?.call(transaction),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CategoryIcon(
              size: 36,
              category: transaction.category,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.category.label,
                          style: TextStyles.titleExtraSmall.copyWith(
                            color: AppColors.fontPrimary,
                          ),
                        ),
                        Text(
                          transaction.remarks ?? 'No remarks',
                          style: TextStyles.bodySmall.copyWith(
                            color: AppColors.fontSubtitle,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        amount,
                        style: TextStyles.titleExtraSmall.copyWith(
                            // color: AppColors.fontWarning,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
