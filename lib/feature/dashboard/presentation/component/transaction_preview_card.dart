import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/categories/presentation/helper/category_helper.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/dashboard_drawer_card_base.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/presentation/helper/transaction_helper.dart';
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
    final category = CategoryHelper.of(context).watchCategoryWithId(
      transaction.categoryId,
    );

    return DashboardDrawerCardBase(
      category: category,
      onTap: () => TransactionHelper.of(context).showTransactionDetailsModal(
        transaction,
        allowEditing: false,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: AppTextStyles.titleExtraSmall,
                ),
                if (transaction.remarks != null)
                  Text(
                    transaction.remarks ?? 'No remarks',
                    style: AppTextStyles.bodyRegular.copyWith(
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
                style: AppTextStyles.titleExtraSmall.copyWith(
                  color: AppColors.fontWarning,
                ),
              ),
              Text(
                Formatter.date(transaction.date),
                style: AppTextStyles.bodyRegular.copyWith(
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
