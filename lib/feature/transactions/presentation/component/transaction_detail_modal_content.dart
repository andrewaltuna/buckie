import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/helper/haptic_feedback_helper.dart';
import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/categories/presentation/helper/category_helper.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/category_icon_display.dart';
import 'package:expense_tracker/feature/transactions/presentation/screen/update_transaction_screen.dart';
import 'package:expense_tracker/feature/transactions/presentation/view_model/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailModalContent extends StatelessWidget {
  const TransactionDetailModalContent({
    required this.transaction,
    this.allowEditing = true,
    super.key,
  });

  final Transaction transaction;
  final bool allowEditing;

  @override
  Widget build(BuildContext context) {
    return ModalBase(
      header: _Header(
        transaction: transaction,
        allowEditting: allowEditing,
      ),
      body: _Body(
        transaction: transaction,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.transaction,
    required this.allowEditting,
  });

  final Transaction transaction;
  final bool allowEditting;

  void _onUpdate(BuildContext context) {
    HapticFeedbackHelper.light();

    Navigator.of(context).pop();

    UpdateTransactionScreen.navigateTo(
      context: context,
      transaction: transaction,
    );
  }

  void _onDelete(BuildContext context) {
    HapticFeedbackHelper.light();

    Navigator.of(context).pop();

    context
        .read<TransactionsViewModel>()
        .add(TransactionsItemDeleted(transaction));
  }

  @override
  Widget build(BuildContext context) {
    final category =
        CategoryHelper.of(context).watchCategoryWithId(transaction.categoryId);

    return Row(
      children: [
        CategoryIconDisplay(
          size: 40,
          category: category,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.name,
              style: AppTextStyles.titleSmall,
            ),
            Text(
              Formatter.date(transaction.date),
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.fontSecondary,
              ),
            ),
          ],
        ),
        const Spacer(),
        if (allowEditting) ...[
          CustomInkWell(
            width: 36,
            height: 36,
            borderRadius: 12,
            color: AppColors.accent,
            onTap: () => _onUpdate(context),
            child: const Icon(
              Icons.edit,
              color: AppColors.fontButtonPrimary,
            ),
          ),
          const SizedBox(width: 8),
          CustomInkWell(
            width: 36,
            height: 36,
            borderRadius: 12,
            color: AppColors.fontWarning,
            onTap: () => _onDelete(context),
            child: const Icon(
              Icons.delete,
              color: AppColors.fontButtonPrimary,
            ),
          ),
        ],
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amount',
          style: AppTextStyles.titleSmall,
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                Formatter.currency(transaction.amount),
                style: AppTextStyles.bodyRegular.copyWith(
                  color: AppColors.fontSecondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Remarks',
          style: AppTextStyles.titleSmall,
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                transaction.remarks ?? 'No remarks',
                style: AppTextStyles.bodyRegular.copyWith(
                  color: AppColors.fontSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
