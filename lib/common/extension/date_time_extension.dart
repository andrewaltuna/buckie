import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime get dateOnly => DateTime(year, month, day);

  TransactionMonth toTransactionMonth() {
    return TransactionMonth(
      year: year,
      month: month,
    );
  }

  String dayOfWeek({bool shortened = false}) {
    if (shortened) {
      return DateFormat('EEE').format(this);
    }
    return DateFormat('EEEE').format(this);
  }
}
