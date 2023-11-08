import 'package:expense_tracker/common/components/main_scaffold.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  static const routeName = '/transactions';

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Transactions',
      body: Container(),
    );
  }
}
