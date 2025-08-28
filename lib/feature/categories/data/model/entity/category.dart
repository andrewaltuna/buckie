import 'package:equatable/equatable.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.transactions,
  });

  final int id;
  final List<Transaction> transactions;

  double get expense => transactions.fold(
        0,
        (previous, transaction) => previous + transaction.amount,
      );

  @override
  List<Object?> get props => [
        id,
        expense,
      ];
}
