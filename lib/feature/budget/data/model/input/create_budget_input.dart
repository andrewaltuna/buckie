import 'package:equatable/equatable.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';

class CreateBudgetInput extends Equatable {
  const CreateBudgetInput({
    required this.month,
    required this.budget,
  });

  final TransactionMonth month;
  final int budget;

  Map<String, dynamic> toJson() {
    return {
      'month': month.toDate(),
      'budget': budget,
    };
  }

  @override
  List<Object?> get props => [month, budget];
}
