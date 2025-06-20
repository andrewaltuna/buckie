import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/helper/formatter.dart';

class TransactionMonth extends Equatable {
  const TransactionMonth({
    required this.year,
    required this.month,
  });

  factory TransactionMonth.fromDate(DateTime date) {
    return TransactionMonth(
      year: date.year,
      month: date.month,
    );
  }

  final int year;
  final int month;

  TransactionMonth copyWith({
    int? year,
    int? month,
  }) {
    return TransactionMonth(
      year: year ?? this.year,
      month: month ?? this.month,
    );
  }

  DateTime toDateTime() => DateTime(year, month);

  String toIso8601String() => toDateTime().toIso8601String();

  @override
  String toString() => Formatter.date(toDateTime(), includeDay: false);

  @override
  List<Object?> get props => [year, month];
}
