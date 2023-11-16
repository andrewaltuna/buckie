import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/transactions/data/model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionListCard extends StatelessWidget {
  const TransactionListCard({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.widgetBackgroundPrimary,
      borderRadius: BorderRadius.circular(15),
      child: Column(
        children: [
          Row(
            children: [
              Text(transaction.label),
              Text('${transaction.dateCreated}'),
            ],
          ),
          Row(
            children: [
              Text(
                transaction.remarks,
                style: TextStyles.body.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
