part of 'transactions_view_model.dart';

sealed class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object?> get props => [];
}

class TransactionsRecentsRequested extends TransactionsEvent {
  const TransactionsRecentsRequested();
}

class TransactionsRequested extends TransactionsEvent {
  const TransactionsRequested([this.month]);

  final TransactionMonth? month;

  @override
  List<Object?> get props => [month];
}

class TransactionsItemCreated extends TransactionsEvent {
  const TransactionsItemCreated(this.transaction);

  final Transaction transaction;

  @override
  List<Object> get props => [transaction];
}

class TransactionsItemDeleted extends TransactionsEvent {
  const TransactionsItemDeleted(this.transaction);

  final Transaction transaction;

  @override
  List<Object> get props => [transaction];
}

class TransactionsItemUpdated extends TransactionsEvent {
  const TransactionsItemUpdated(this.transaction);

  final Transaction transaction;

  @override
  List<Object> get props => [transaction];
}
