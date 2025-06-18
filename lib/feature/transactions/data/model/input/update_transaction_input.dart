import 'package:expense_tracker/common/extension/enum.dart';
import 'package:expense_tracker/feature/categories/data/model/transaction_category.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/create_transaction_input.dart';

class UpdateTransactionInput extends CreateTransactionInput {
  UpdateTransactionInput({
    required this.id,
    required super.amount,
    required super.remarks,
    required super.date,
    required super.category,
  });

  final String id;

  UpdateTransactionInput copyWith({
    String? id,
    double? amount,
    String? remarks,
    DateTime? date,
    TransactionCategoryType? category,
  }) {
    return UpdateTransactionInput(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      remarks: remarks ?? this.remarks,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'remarks': remarks == '' ? null : remarks,
      'category': category.value,
      'date': date.toString(),
    };
  }
}
