part of 'create_transaction_view_model.dart';

class CreateTransactionState extends Equatable {
  const CreateTransactionState({
    this.status = ViewModelStatus.initial,
    this.date,
    this.amount = 0,
    this.categoryId = CategoryDetails.fallbackId,
    this.remarks,
    this.error,
  });

  final ViewModelStatus status;
  final DateTime? date;
  final String? remarks;
  final double amount;
  final int categoryId;
  final Exception? error;

  CreateTransactionState copyWith({
    ViewModelStatus? status,
    DateTime? date,
    String? remarks,
    double? amount,
    int? categoryId,
    Exception? error,
  }) {
    return CreateTransactionState(
      status: status ?? this.status,
      date: date ?? this.date,
      remarks: remarks ?? this.remarks,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        date,
        remarks,
        amount,
        categoryId,
        error,
      ];
}
