import 'package:expense_tracker/common/extension/enum.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';

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
  final CategoryType category;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'remarks': remarks == '' ? null : remarks,
      'category': category.value,
      'date': date.toIso8601String(),
      'created_at': DateTime.now().toIso8601String(),
    };
  }
}
