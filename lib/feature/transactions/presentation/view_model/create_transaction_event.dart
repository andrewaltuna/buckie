part of 'create_transaction_view_model.dart';

sealed class CreateTransactionEvent extends Equatable {
  const CreateTransactionEvent();

  @override
  List<Object> get props => [];
}

class CreateTransactionSubmitted extends CreateTransactionEvent {
  const CreateTransactionSubmitted();
}

class CreateTransactionDateUpdated extends CreateTransactionEvent {
  const CreateTransactionDateUpdated(this.date);

  final DateTime date;

  @override
  List<Object> get props => [date];
}

class CreateTransactionRemarksUpdated extends CreateTransactionEvent {
  const CreateTransactionRemarksUpdated(this.remarks);

  final String remarks;

  @override
  List<Object> get props => [remarks];
}

class CreateTransactionAmountUpdated extends CreateTransactionEvent {
  const CreateTransactionAmountUpdated(this.amount);

  final double amount;

  @override
  List<Object> get props => [amount];
}

class CreateTransactionCategoryUpdated extends CreateTransactionEvent {
  const CreateTransactionCategoryUpdated(this.category);

  final CategoryType category;

  @override
  List<Object> get props => [category];
}
