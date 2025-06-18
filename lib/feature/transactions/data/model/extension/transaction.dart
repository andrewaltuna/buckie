import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';

extension TransactionListHelper on List<Transaction> {
  double sumAmount() {
    return fold(0, (sum, transaction) => sum + transaction.amount);
  }
}
