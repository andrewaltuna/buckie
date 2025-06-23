part of 'budgets_view_model.dart';

typedef BudgetsByMonth = Map<String, double?>;

class BudgetsState extends Equatable {
  const BudgetsState({
    this.status = ViewModelStatus.initial,
    this.budgetsByMonth = const {},
    this.latestBudget,
    this.error,
  });

  final ViewModelStatus status;
  final BudgetsByMonth budgetsByMonth;
  final double? latestBudget;
  final Exception? error;

  BudgetsState copyWith({
    ViewModelStatus? status,
    BudgetsByMonth? budgetsByMonth,
    double? latestBudget,
    Exception? error,
  }) {
    return BudgetsState(
      status: status ?? this.status,
      budgetsByMonth: budgetsByMonth ?? this.budgetsByMonth,
      latestBudget: latestBudget ?? this.latestBudget,
      error: error ?? this.error,
    );
  }

  double? budgetOf(String monthKey) => budgetsByMonth[monthKey] ?? 0;

  @override
  List<Object?> get props => [
        status,
        budgetsByMonth,
        latestBudget,
        error,
      ];
}
