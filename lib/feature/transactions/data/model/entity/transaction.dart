import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/extension/enum.dart';
import 'package:expense_tracker/common/extension/json.dart';
import 'package:expense_tracker/feature/categories/data/model/transaction_category.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';

class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.amount,
    required this.remarks,
    required this.date,
    required this.category,
  });

  final String id;
  final double amount;
  final String? remarks;
  final DateTime date;
  final TransactionCategoryType category;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json.parseString('id'),
      amount: json.parseDouble('amount'),
      remarks: json.tryParseString('remarks'),
      date: json.parseDateTime('date'),
      category: TransactionCategoryType.values.fromValue(json['category']),
    );
  }

  static List<Transaction> generatePlaceholderTransactions(int count) {
    final labels = [
      'Grab',
      'McDonalds',
      'Starbucks',
      'Rent',
      'WIFI',
      'Utilities',
      'Internet',
    ];

    return List.generate(count, (index) {
      labels.shuffle();
      final cats = [...TransactionCategoryType.values]..shuffle();
      return Transaction(
        id: '',
        amount: Random().nextDouble() * 100,
        remarks: 'Example remarks',
        date: DateTime.now().subtract(
          Duration(days: Random().nextInt(30)),
        ),
        category: cats.first,
      );
    })
      ..sortBy((element) => element.date);
  }

  Transaction copyWith({
    String? id,
    double? amount,
    String? remarks,
    DateTime? date,
    TransactionCategoryType? category,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      remarks: remarks ?? this.remarks,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }

  String get monthAndYear => '${date.month}-${date.year}';

  TransactionMonth get transactionMonth => TransactionMonth(
        year: date.year,
        month: date.month,
      );

  @override
  List<Object?> get props => [
        id,
        amount,
        remarks,
        date,
        category,
      ];
}
