part of 'transactions_view_model.dart';

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

  List<Category> toCategories(String monthKey) {
    final transactions = transactionsOf(monthKey);

    if (transactions == null) return [];

    final trxByCategory = groupBy(
      transactions,
      (transaction) => transaction.category,
    );

    final categories = trxByCategory.entries
        .map(
          (entry) => Category(
            type: entry.key,
            transactions: entry.value,
          ),
        )
        .toList();

    return categories
      ..sort(
        (a, b) => b.expense.compareTo(a.expense),
      );
  }

  double? totalExpensesOf(String monthKey) {
    final transactions = transactionsByMonth[monthKey];

    if (transactions == null) return null;

    return transactions.fold<double>(
      0.0,
      (sum, transaction) => sum + transaction.amount,
    );
  }

  List<Transaction>? transactionsOf(String monthKey) {
    return transactionsByMonth[monthKey];
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
