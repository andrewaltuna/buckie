part of 'transactions_view_model.dart';

sealed class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object?> get props => [];
}

class TransactionsStreamInitialized extends TransactionsEvent {
  const TransactionsStreamInitialized();
}

class TransactionsRequested extends TransactionsEvent {
  const TransactionsRequested({
    required this.month,
    this.refresh = false,
    this.fetchRecents = false,
  });

  final TransactionMonth month;
  final bool refresh;
  final bool fetchRecents;

  @override
  List<Object?> get props => [
        month,
        refresh,
        fetchRecents,
      ];
}

class TransactionsItemUpdated extends TransactionsEvent {
  const TransactionsItemUpdated({
    required this.newTransaction,
    required this.oldTransaction,
  });

  final Transaction newTransaction;
  final Transaction oldTransaction;

  @override
  List<Object> get props => [
        newTransaction,
        oldTransaction,
      ];
}

class TransactionsItemDeleted extends TransactionsEvent {
  const TransactionsItemDeleted(this.transaction);

  final Transaction transaction;

  @override
  List<Object> get props => [transaction];
}
