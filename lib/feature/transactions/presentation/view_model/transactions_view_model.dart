import 'dart:async';

import 'package:collection/collection.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:expense_tracker/common/extension/list.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/output/transaction_stream_output.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsViewModel extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsViewModel(
    this._repository, {
    TransactionMonth? month,
  }) : super(const TransactionsState()) {
    on<TransactionsRecentsRequested>(_onRecentsRequested);
    on<TransactionsRequested>(_onRequested);
    on<TransactionsItemCreated>(_onItemCreated);
    on<TransactionsItemUpdated>(_onItemUpdated);
    on<TransactionsItemDeleted>(_onItemDeleted);

    _trxSubscription = _repository.transactionsStream.listen(
      (output) {
        final operation = output.operation;
        final key = output.transaction.monthKey;

        if (!state.transactionsByMonth.containsKey(key)) return;

        if (operation.isInsert) {
          add(TransactionsItemCreated(output.transaction));
        } else if (operation.isUpdate) {
          add(TransactionsItemUpdated(output.transaction));
        } else if (operation.isDelete) {
          add(TransactionsItemDeleted(output.transaction));
        }
      },
    );
  }

  final TransactionRepositoryInterface _repository;

  StreamSubscription<TransactionStreamOutput>? _trxSubscription;

  Future<void> _onRequested(
    TransactionsRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      if (state.transactionsByMonth.containsKey(event.month!.key)) return;

      emit(state.copyWith(status: ViewModelStatus.loading));

      final transactions = await _repository.getTransactions(
        month: event.month,
      );

      TransactionsByMonth? transactionsByMonth;

      if (event.month != null) {
        transactionsByMonth = Map.of(state.transactionsByMonth)
          ..[event.month!.key] = transactions;
      }

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          transactionsByMonth: transactionsByMonth,
          selectedMonth: event.month,
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

  Future<void> _onRecentsRequested(
    TransactionsRecentsRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final transactions = await _repository.getTransactions();

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          recentTransactions: transactions,
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
    final key = event.transaction.monthKey;
    final transactionsByMonth = Map.of(state.transactionsByMonth);
    final transactions = List.of(transactionsByMonth[key]!)
      ..add(event.transaction);

    transactionsByMonth[key] = _sortByDate(transactions);

    emit(
      state.copyWith(
        transactionsByMonth: transactionsByMonth,
      ),
    );
  }

  void _onItemUpdated(
    TransactionsItemUpdated event,
    Emitter<TransactionsState> emit,
  ) {
    final key = event.transaction.monthKey;
    final transactionsByMonth = Map.of(state.transactionsByMonth);
    final transactions = List.of(transactionsByMonth[key]!);

    // Update transaction
    final index = transactions.indexWhere(
      (transaction) => transaction.id == event.transaction.id,
    );
    transactions.replaceAt(index, event.transaction);

    transactionsByMonth[key] = _sortByDate(transactions);

    emit(
      state.copyWith(
        transactionsByMonth: transactionsByMonth,
      ),
    );
  }

  void _onItemDeleted(
    TransactionsItemDeleted event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      await _repository.deleteTransaction(event.transaction.id);

      final key = event.transaction.monthKey;
      final transactionsByMonth = Map.of(state.transactionsByMonth);
      final transactions = List.of(transactionsByMonth[key]!);

      transactions.removeWhere(
        (transaction) => transaction.id == event.transaction.id,
      );

      transactionsByMonth[key] = _sortByDate(transactions);

      emit(
        state.copyWith(
          transactionsByMonth: transactionsByMonth,
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

  List<Transaction> _sortByDate(List<Transaction> transactions) {
    return transactions..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<void> close() {
    _trxSubscription?.cancel();

    return super.close();
  }
}
