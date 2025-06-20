part of 'transactions_view_model.dart';

class TransactionsState extends Equatable {
  const TransactionsState({
    this.status = ViewModelStatus.initial,
    this.transactions = const [],
    this.totalExpense = 0.0,
    this.error,
  });

  final ViewModelStatus status;
  final List<Transaction> transactions;
  final double totalExpense;
  final Exception? error;

  TransactionsState copyWith({
    ViewModelStatus? status,
    List<Transaction>? transactions,
    double? totalExpense,
    Exception? error,
  }) {
    return TransactionsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      totalExpense: totalExpense ?? this.totalExpense,
      error: error ?? this.error,
    );
  }

  List<Transaction> recentTransactions([int count = 10]) {
    return transactions.take(count).toList();
  }

  Map<DateTime, List<Transaction>> byDate() => groupBy(
        transactions,
        (transaction) => transaction.date,
      );

  List<Category> toCategories() {
    final categories = groupBy(
      transactions,
      (transaction) => transaction.category,
    );

    return categories.entries.map((entry) {
      return Category(
        type: entry.key,
        totalExpense: entry.value.fold(
          0,
          (previous, transaction) => previous + transaction.amount,
        ),
      );
    }).toList();
  }

  String get totalExpenseLabel => Formatter.currency(totalExpense);

  @override
  List<Object?> get props => [
        status,
        transactions,
        totalExpense,
        error,
      ];
}
