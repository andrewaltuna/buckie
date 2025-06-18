import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/presentation/component/category_display.dart';
import 'package:expense_tracker/feature/transactions/presentation/screen/update_transaction_screen.dart';
import 'package:expense_tracker/feature/transactions/presentation/view_model/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TransactionDetailModalContent extends StatelessWidget {
  const TransactionDetailModalContent({
    required this.transaction,
    super.key,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return ModalBase(
      header: _Header(
        transaction: transaction,
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
  });

  final Transaction transaction;

  void _onUpdate(BuildContext context) {
    Navigator.of(context).pop();

    context.pushNamed(
      UpdateTransactionScreen.routeName,
      pathParameters: {
        'id': transaction.id,
      },
      extra: transaction,
    );
  }

  void _onDelete(BuildContext context) {
    context
        .read<TransactionsViewModel>()
        .add(TransactionsItemDeleted(transaction.id));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CategoryDisplay(
          height: 36,
          width: 36,
          category: transaction.category,
          iconOnly: true,
          iconSize: 20,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.category.label,
              style: TextStyles.titleSmall,
            ),
            Text(
              Formatter.date(transaction.date),
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
                Formatter.currency(transaction.amount),
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
                transaction.remarks ?? 'No remarks',
                style: TextStyles.bodyRegular.copyWith(
                  color: AppColors.fontSubtitle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
