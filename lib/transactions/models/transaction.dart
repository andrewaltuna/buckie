import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  const Transaction({
    required this.label,
    required this.value,
    required this.remarks,
    required this.dateCreated,
    this.dateUpdated,
  });

  final String label;
  final double value;
  final String remarks;
  final DateTime dateCreated;
  final DateTime? dateUpdated;

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
      return Transaction(
        label: labels.first,
        value: Random().nextDouble() * 500,
        remarks: 'Example remarks',
        dateCreated: DateTime.now().subtract(
          Duration(days: Random().nextInt(30)),
        ),
      );
    })
      ..sortBy((element) => element.dateCreated);
  }

  Transaction copyWith({
    String? label,
    double? value,
    String? remarks,
    DateTime? dateUpdated,
  }) {
    return Transaction(
      label: label ?? this.label,
      value: value ?? this.value,
      remarks: remarks ?? this.remarks,
      dateCreated: dateCreated,
      dateUpdated: dateUpdated ?? this.dateUpdated,
    );
  }

  @override
  List<Object?> get props => [
        label,
        value,
        remarks,
        dateCreated,
        dateUpdated,
      ];
}
