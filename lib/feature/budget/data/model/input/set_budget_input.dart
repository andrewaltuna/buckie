import 'package:equatable/equatable.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';

class SetBudgetInput extends Equatable {
  const SetBudgetInput({
    required this.month,
    required this.amount,
  });

  final TransactionMonth month;
  final double? amount;

  Map<String, dynamic> toJson() {
    return {
      'date': month.toIso8601String(),
      'amount': amount,
      'modified_at': DateTime.now().toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [month, amount];
}
