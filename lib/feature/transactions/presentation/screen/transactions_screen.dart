import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/transactions/data/model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  static const routeName = '/transactions';

  @override
  Widget build(BuildContext context) {
    final transactions = Transaction.generatePlaceholderTransactions(30);

    return MainScaffold(
      title: 'Transactions',
      body: ListView(
        children: const [
          Text(
            'TODAY',
            style: TextStyles.title,
          ),
          Text(
            'PAST WEEK',
            style: TextStyles.title,
          ),
          Text(
            'PAST MONTH',
            style: TextStyles.title,
          ),
        ],
      ),
    );
  }
}
