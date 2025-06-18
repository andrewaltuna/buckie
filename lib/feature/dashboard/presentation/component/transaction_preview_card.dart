import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:flutter/material.dart';

class TransactionPreviewCard extends StatelessWidget {
  const TransactionPreviewCard({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final amount = Formatter.currency(transaction.amount);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.widgetBackgroundSecondary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: transaction.category.color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              transaction.category.icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
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
                        style: TextStyles.titleSmall.copyWith(
                          color: AppColors.fontPrimary,
                        ),
                      ),
                      Text(
                        transaction.remarks ?? 'No remarks',
                        style: TextStyles.bodyRegular.copyWith(
                          color: AppColors.fontSubtitle,
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
                      style: TextStyles.titleSmall.copyWith(
                        color: AppColors.fontWarning,
                      ),
                    ),
                    Text(
                      Formatter.date(transaction.date),
                      style: TextStyles.bodyRegular.copyWith(
                        color: AppColors.fontSubtitle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
