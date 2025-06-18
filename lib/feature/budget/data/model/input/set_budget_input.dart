import 'package:equatable/equatable.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';

class SetBudgetInput extends Equatable {
  const SetBudgetInput({
    required this.month,
    required this.budget,
  });

  final TransactionMonth month;
  final double? budget;

  Map<String, dynamic> toJson() {
    return {
      'month': month.toDate().toString(),
      'budget': budget,
    };
  }

  @override
  List<Object?> get props => [month, budget];
}
