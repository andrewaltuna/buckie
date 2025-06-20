part of 'budget_view_model.dart';

class BudgetState extends Equatable {
  const BudgetState({
    this.status = ViewModelStatus.initial,
    this.amount,
    this.error,
  });

  final ViewModelStatus status;
  final double? amount;
  final Exception? error;

  BudgetState copyWith({
    ViewModelStatus? status,
    ValueGetter<double?>? amount,
    Exception? error,
  }) {
    return BudgetState(
      status: status ?? this.status,
      amount: amount != null ? amount() : this.amount,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        amount,
        error,
      ];
}
