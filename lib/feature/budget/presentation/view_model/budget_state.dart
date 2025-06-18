part of 'budget_view_model.dart';

class BudgetState extends Equatable {
  const BudgetState({
    this.status = ViewModelStatus.initial,
    this.budget = 0,
    this.error,
  });

  final ViewModelStatus status;
  final int budget;
  final Exception? error;

  BudgetState copyWith({
    ViewModelStatus? status,
    int? budget,
    Exception? error,
  }) {
    return BudgetState(
      status: status ?? this.status,
      budget: budget ?? this.budget,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        budget,
        error,
      ];
}
