import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/helper/formatter.dart';

class TransactionMonth extends Equatable {
  const TransactionMonth({
    required this.year,
    required this.month,
  });

  final int year;
  final int month;

  DateTime toDate() => DateTime(year, month);

  @override
  String toString() => Formatter.date(toDate(), includeDay: false);

  @override
  List<Object?> get props => [year, month];
}
