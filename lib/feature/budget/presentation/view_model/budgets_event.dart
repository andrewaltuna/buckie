part of 'budgets_view_model.dart';

sealed class BudgetsEvent extends Equatable {
  const BudgetsEvent();

  @override
  List<Object?> get props => [];
}

class BudgetsLatestRequested extends BudgetsEvent {
  const BudgetsLatestRequested();

  @override
  List<Object> get props => [];
}

class BudgetsRequested extends BudgetsEvent {
  const BudgetsRequested(this.month);

  final TransactionMonth month;

  @override
  List<Object?> get props => [month];
}

class BudgetsSet extends BudgetsEvent {
  const BudgetsSet(
    this.month, {
    this.amount = 0,
  });

  final double amount;
  final TransactionMonth month;

  @override
  List<Object?> get props => [amount, month];
}
