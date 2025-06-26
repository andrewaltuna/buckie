import 'package:collection/collection.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';

extension TransactionListExtension on List<Transaction> {
  double sumAmount() {
    return fold(0, (sum, transaction) => sum + transaction.amount);
  }

  Map<DateTime, List<Transaction>> byDate() => groupBy(
        this,
        (transaction) => transaction.date,
      );
}
