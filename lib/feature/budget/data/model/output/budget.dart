import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/extension/json.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';

class Budget extends Equatable {
  const Budget({
    required this.month,
    this.amount,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      month: TransactionMonth.fromDate(json.parseDateTime('date')),
      amount: json['budget'] as double?,
    );
  }

  final TransactionMonth month;
  final double? amount;

  @override
  List<Object?> get props => [month, amount];
}
