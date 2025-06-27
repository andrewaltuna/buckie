import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/dashboard_drawer_card_base.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/presentation/helper/transactions_helper.dart';
import 'package:flutter/material.dart';

class TransactionPreviewCard extends StatelessWidget {
  const TransactionPreviewCard({
    required this.transaction,
    super.key,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final amount = Formatter.currency(transaction.amount);

    return DashboardDrawerCardBase(
      category: transaction.category,
      onTap: () => TransactionsHelper.of(context).showTransactionDetailsModal(
        transaction,
        allowEditting: false,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.category.label,
                  style: TextStyles.titleExtraSmall,
                ),
                if (transaction.remarks != null)
                  Text(
                    transaction.remarks ?? 'No remarks',
                    style: TextStyles.bodyRegular.copyWith(
                      color: AppColors.fontSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyles.titleExtraSmall.copyWith(
                  color: AppColors.fontWarning,
                ),
              ),
              Text(
                Formatter.date(transaction.date),
                style: TextStyles.bodyRegular.copyWith(
                  color: AppColors.fontSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
