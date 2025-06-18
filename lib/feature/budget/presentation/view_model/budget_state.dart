part of 'budget_view_model.dart';

class BudgetState extends Equatable {
  const BudgetState({
    this.status = ViewModelStatus.initial,
    this.budget,
    this.error,
  });

  final ViewModelStatus status;
  final double? budget;
  final Exception? error;

  BudgetState copyWith({
    ViewModelStatus? status,
    ValueGetter<double?>? budget,
    Exception? error,
  }) {
    return BudgetState(
      status: status ?? this.status,
      budget: budget != null ? budget() : this.budget,
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
