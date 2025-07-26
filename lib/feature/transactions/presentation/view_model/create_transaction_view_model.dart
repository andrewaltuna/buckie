import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:expense_tracker/common/extension/date_time_extension.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/transactions/data/exception/transaction_exception.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/create_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/update_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_transaction_event.dart';
part 'create_transaction_state.dart';

class CreateTransactionViewModel
    extends Bloc<CreateTransactionEvent, CreateTransactionState> {
  CreateTransactionViewModel(
    this._repository, {
    String? transactionId,
  })  : _transactionId = transactionId,
        super(const CreateTransactionState()) {
    on<CreateTransactionDateUpdated>(_onDateUpdated);
    on<CreateTransactionRemarksUpdated>(_onRemarksUpdated);
    on<CreateTransactionAmountUpdated>(_onAmountUpdated);
    on<CreateTransactionCategoryUpdated>(_onCategoryUpdated);
    on<CreateTransactionSubmitted>(_onSubmitted);
  }

  final TransactionRepositoryInterface _repository;
  final String? _transactionId;

  void _onDateUpdated(
    CreateTransactionDateUpdated event,
    Emitter<CreateTransactionState> emit,
  ) {
    emit(state.copyWith(date: event.date));
  }

  void _onRemarksUpdated(
    CreateTransactionRemarksUpdated event,
    Emitter<CreateTransactionState> emit,
  ) {
    emit(state.copyWith(remarks: event.remarks));
  }

  void _onAmountUpdated(
    CreateTransactionAmountUpdated event,
    Emitter<CreateTransactionState> emit,
  ) {
    emit(state.copyWith(amount: event.amount));
  }

  void _onCategoryUpdated(
    CreateTransactionCategoryUpdated event,
    Emitter<CreateTransactionState> emit,
  ) {
    emit(state.copyWith(categoryId: event.id));
  }

  Future<void> _onSubmitted(
    CreateTransactionSubmitted event,
    Emitter<CreateTransactionState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      if (state.amount <= 0) {
        throw const TransactionInvalidAmountException();
      }

      final date = (state.date ?? DateTime.now()).dateOnly;

      if (_transactionId != null) {
        await _repository.updateTransaction(
          UpdateTransactionInput(
            id: _transactionId!,
            amount: state.amount,
            remarks: state.remarks,
            date: date,
            categoryId: state.categoryId,
          ),
        );
      } else {
        await _repository.createTransaction(
          CreateTransactionInput(
            amount: state.amount,
            remarks: state.remarks,
            date: date,
            categoryId: state.categoryId,
          ),
        );
      }

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }
}
