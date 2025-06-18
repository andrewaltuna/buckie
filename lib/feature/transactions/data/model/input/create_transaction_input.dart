import 'package:expense_tracker/common/extension/enum.dart';
import 'package:expense_tracker/feature/categories/data/model/transaction_category.dart';

class CreateTransactionInput {
  const CreateTransactionInput({
    required this.amount,
    required this.remarks,
    required this.date,
    required this.category,
  });

  final double amount;
  final String? remarks;
  final DateTime date;
  final TransactionCategoryType category;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'remarks': remarks == '' ? null : remarks,
      'category': category.value,
      'date': date.toString(),
    };
  }
}
