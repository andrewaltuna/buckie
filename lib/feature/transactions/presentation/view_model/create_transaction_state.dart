part of 'create_transaction_view_model.dart';

class CreateTransactionState extends Equatable {
  const CreateTransactionState({
    this.status = ViewModelStatus.initial,
    this.date,
    this.amount = 0,
    this.category = CategoryType.other,
    this.remarks,
    this.error,
  });

  final ViewModelStatus status;
  final DateTime? date;
  final String? remarks;
  final double amount;
  final CategoryType category;
  final Exception? error;

  CreateTransactionState copyWith({
    ViewModelStatus? status,
    DateTime? date,
    String? remarks,
    double? amount,
    CategoryType? category,
    Exception? error,
  }) {
    return CreateTransactionState(
      status: status ?? this.status,
      date: date ?? this.date,
      remarks: remarks ?? this.remarks,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        date,
        remarks,
        amount,
        category,
        error,
      ];
}
