import 'package:expense_tracker/feature/transactions/data/model/input/create_transaction_input.dart';

class UpdateTransactionInput extends CreateTransactionInput {
  UpdateTransactionInput({
    required this.id,
    required super.amount,
    required super.remarks,
    required super.date,
    required super.categoryId,
  });

  final int id;

  UpdateTransactionInput copyWith({
    int? id,
    double? amount,
    String? remarks,
    DateTime? date,
    int? categoryId,
  }) {
    return UpdateTransactionInput(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      remarks: remarks ?? this.remarks,
      date: date ?? this.date,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'remarks': remarks == '' ? null : remarks,
      'category_id': categoryId,
      'date': date.toIso8601String(),
    };
  }
}
