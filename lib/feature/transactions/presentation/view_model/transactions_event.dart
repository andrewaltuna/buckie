part of 'transactions_view_model.dart';

sealed class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

class TransactionsStreamInitialized extends TransactionsEvent {
  const TransactionsStreamInitialized();
}

class TransactionsRequested extends TransactionsEvent {
  const TransactionsRequested();
}

class TransactionsItemCreated extends TransactionsEvent {
  const TransactionsItemCreated(this.transaction);

  final Transaction transaction;

  @override
  List<Object> get props => [transaction];
}

class TransactionsItemDeleted extends TransactionsEvent {
  const TransactionsItemDeleted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class TransactionsItemUpdated extends TransactionsEvent {
  const TransactionsItemUpdated(this.transaction);

  final Transaction transaction;

  @override
  List<Object> get props => [transaction];
}
