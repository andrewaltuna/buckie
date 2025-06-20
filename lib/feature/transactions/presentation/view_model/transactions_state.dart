part of 'transactions_view_model.dart';

typedef TransactionsByMonth = Map<String, List<Transaction>>;

class TransactionsState extends Equatable {
  const TransactionsState({
    this.status = ViewModelStatus.initial,
    this.recentTransactions = const [],
    this.transactionsByMonth = const {},
    this.selectedMonth,
    this.error,
  });

  final ViewModelStatus status;
  final List<Transaction> recentTransactions;
  final TransactionsByMonth transactionsByMonth;
  final TransactionMonth? selectedMonth;
  final Exception? error;

  TransactionsState copyWith({
    ViewModelStatus? status,
    List<Transaction>? recentTransactions,
    TransactionsByMonth? transactionsByMonth,
    TransactionMonth? selectedMonth,
    Exception? error,
  }) {
    return TransactionsState(
      status: status ?? this.status,
      recentTransactions: recentTransactions ?? this.recentTransactions,
      transactionsByMonth: transactionsByMonth ?? this.transactionsByMonth,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      error: error ?? this.error,
    );
  }

  List<Category> toCategories() {
    final categories = groupBy(
      recentTransactions,
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

  @override
  List<Object?> get props => [
        status,
        recentTransactions,
        transactionsByMonth,
        selectedMonth,
        error,
      ];
}
