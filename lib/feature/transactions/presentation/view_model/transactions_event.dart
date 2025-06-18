part of 'transactions_view_model.dart';

sealed class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

final class TransactionsRequested extends TransactionsEvent {
  const TransactionsRequested();
}

final class TransactionsItemCreated extends TransactionsEvent {
  const TransactionsItemCreated(this.transaction);

  final Transaction transaction;

  @override
  List<Object> get props => [transaction];
}

final class TransactionsItemDeleted extends TransactionsEvent {
  const TransactionsItemDeleted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class TransactionsItemUpdated extends TransactionsEvent {
  const TransactionsItemUpdated(this.transaction);

  final Transaction transaction;

  @override
  List<Object> get props => [transaction];
}
