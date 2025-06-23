import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/extension/enum.dart';
import 'package:expense_tracker/common/extension/json.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';

typedef TransactionsByMonth = Map<String, List<Transaction>>;
typedef TransactionsByDate = Map<String, List<Transaction>>;

class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.amount,
    required this.remarks,
    required this.date,
    required this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'].toString(),
      amount: json.parseDouble('amount'),
      remarks: json.tryParseString('remarks'),
      date: json.parseDateTime('date'),
      category: CategoryType.values.fromValue(json['category']),
    );
  }

  final String id;
  final double amount;
  final String? remarks;
  final DateTime date;
  final CategoryType category;

  Transaction copyWith({
    String? id,
    double? amount,
    String? remarks,
    DateTime? date,
    CategoryType? category,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      remarks: remarks ?? this.remarks,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }

  TransactionMonth get month => TransactionMonth(
        year: date.year,
        month: date.month,
      );

  String get monthKey => '${date.year}-${date.month}';
  String get dateKey => '${date.year}-${date.month}-${date.day}';

  @override
  List<Object?> get props => [
        id,
        amount,
        remarks,
        date,
        category,
      ];
}
