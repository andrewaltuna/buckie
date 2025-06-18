part of 'budget_view_model.dart';

sealed class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object?> get props => [];
}

class BudgetLatestRequested extends BudgetEvent {
  const BudgetLatestRequested();

  @override
  List<Object> get props => [];
}

class BudgetRequested extends BudgetEvent {
  const BudgetRequested([this.month]);

  final TransactionMonth? month;

  @override
  List<Object?> get props => [month];
}

class BudgetSet extends BudgetEvent {
  const BudgetSet(this.budget);

  final double? budget;

  @override
  List<Object?> get props => [budget];
}
