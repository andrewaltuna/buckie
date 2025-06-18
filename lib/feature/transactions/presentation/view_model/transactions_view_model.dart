import 'dart:async';

import 'package:collection/collection.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:expense_tracker/common/extension/list.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsViewModel extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsViewModel(
    this._repository, {
    TransactionMonth? month,
  })  : _transactionMonth = month,
        super(const TransactionsState()) {
    on<TransactionsStreamInitialized>(_onStreamInitialized);
    on<TransactionsRequested>(_onRequested);
    on<TransactionsItemCreated>(_onItemCreated);
    on<TransactionsItemUpdated>(_onItemUpdated);
    on<TransactionsItemDeleted>(_onItemDeleted);

    _transactionStream = _repository.transactionsStream.listen(
      (affectedMonth) {
        if (_transactionMonth == null || _transactionMonth == affectedMonth) {
          add(const TransactionsRequested());
        }
      },
    );
  }

  final TransactionRepositoryInterface _repository;
  final TransactionMonth? _transactionMonth;

  StreamSubscription<TransactionMonth>? _transactionStream;

  Future<void> _onStreamInitialized(_, __) async {
    _repository.initializeTransactionsStream();
  }

  Future<void> _onRequested(
    TransactionsRequested _,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final transactions = await _repository.getTransactions(
        month: _transactionMonth,
      );

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          transactions: transactions,
          totalExpense: _computeTotal(transactions),
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

  Future<void> _onItemCreated(
    TransactionsItemCreated event,
    Emitter<TransactionsState> emit,
  ) async {
    final transactions = [...state.transactions, event.transaction];

    emit(
      state.copyWith(
        transactions: transactions,
      ),
    );
  }

  void _onItemUpdated(
    TransactionsItemUpdated event,
    Emitter<TransactionsState> emit,
  ) {
    final index = state.transactions.indexWhere(
      (element) => element.id == event.transaction.id,
    );
    final transactions = [...state.transactions]..replaceAt(
        index,
        event.transaction,
      );

    emit(
      state.copyWith(
        status: ViewModelStatus.loaded,
        transactions: transactions,
      ),
    );
  }

  void _onItemDeleted(
    TransactionsItemDeleted event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      await _repository.deleteTransaction(event.id);

      final transactions = [...state.transactions]..removeWhere(
          (element) => element.id == event.id,
        );

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          transactions: transactions,
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

  double _computeTotal(List<Transaction> transactions) {
    return transactions.fold(
      0.0,
      (previous, element) => previous + element.amount,
    );
  }

  @override
  Future<void> close() {
    _transactionStream?.cancel();

    return super.close();
  }
}
