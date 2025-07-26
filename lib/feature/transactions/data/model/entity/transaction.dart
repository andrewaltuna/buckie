import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/extension/json_extension.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
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

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    String prefix = 't_',
  }) {
    return Transaction(
      id: json['${prefix}id'].toString(),
      amount: json.parseDouble('${prefix}amount'),
      remarks: json.tryParseString('${prefix}remarks'),
      date: json.parseDateTime('${prefix}date'),
      category: CategoryDetails.fromJson(json, prefix: 'c_'),
    );
  }

  final String id;
  final double amount;
  final String? remarks;
  final DateTime date;
  final CategoryDetails category;

  Transaction copyWith({
    String? id,
    double? amount,
    String? remarks,
    DateTime? date,
    CategoryDetails? category,
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
