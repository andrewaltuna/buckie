import 'dart:async';

import 'package:collection/collection.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/extension/transaction_extension.dart';
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
    on<TransactionsStreamInitialized>(_onStreamInitialized);
    on<TransactionsRequested>(_onRequested);
    on<TransactionsItemUpdated>(_onItemUpdated);
    on<TransactionsItemDeleted>(_onItemDeleted);
  }

  final TransactionRepositoryInterface _repository;

  StreamSubscription<TransactionStreamOutput>? _trxSubscription;

  void _onStreamInitialized(_, __) {
    _trxSubscription = _repository.transactionsStream.listen(
      (output) {
        final TransactionStreamOutput(
          :operation,
          :newTransaction,
          :oldTransaction
        ) = output;

        final key = (oldTransaction ?? newTransaction)?.monthKey;

        // Only continue if transaction month is already loaded.
        if (!state.transactionsByMonth.containsKey(key)) return;

        if (operation.isDelete) {
          add(TransactionsItemDeleted(output.oldTransaction!));
        } else if (operation.isUpdate) {
          if (newTransaction == null || oldTransaction == null) return;

          add(
            TransactionsItemUpdated(
              newTransaction: newTransaction,
              oldTransaction: oldTransaction,
            ),
          );
        } else {
          if (newTransaction == null) return;

          add(
            TransactionsRequested(
              month: output.newTransaction!.month,
              refresh: true,
              fetchRecents: true,
            ),
          );
        }
      },
    );
  }

  Future<void> _onRequested(
    TransactionsRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      final hasData = state.transactionsByMonth.containsKey(event.month.key);

      if (!event.refresh && hasData) return;

      emit(state.copyWith(status: ViewModelStatus.loading));

      final result = await Future.wait([
        _repository.getTransactions(
          month: event.month,
        ),
        if (event.fetchRecents) _repository.getTransactions(),
      ]);

      final transactions = result.elementAt(0);
      final recents = result.elementAtOrNull(1);

      final transactionsByMonth = Map.of(
        state.transactionsByMonth,
      )..[event.month.key] = transactions;

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          selectedMonth: event.month,
          transactionsByMonth: transactionsByMonth,
          recentTransactions: recents,
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

  void _onItemUpdated(
    TransactionsItemUpdated event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      final isDifferentMonth =
          !event.oldTransaction.isSameMonthAs(event.newTransaction);

      if (isDifferentMonth) {
        final transactionsByMonth = Map.of(state.transactionsByMonth);

        _removeTransaction(
          event.oldTransaction,
          transactionsByMonth: transactionsByMonth,
        );

        emit(
          state.copyWith(
            transactionsByMonth: transactionsByMonth,
          ),
        );
      }

      add(
        TransactionsRequested(
          month: event.newTransaction.month,
          refresh: true,
          fetchRecents: true,
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

  void _onItemDeleted(
    TransactionsItemDeleted event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      await _repository.deleteTransaction(event.transaction.id);

      final transactionsByMonth = Map.of(state.transactionsByMonth);

      _removeTransaction(
        event.transaction,
        transactionsByMonth: transactionsByMonth,
      );

      final recentTransactions = List.of(state.recentTransactions)
        ..removeWhere(
          (element) => element.id == event.transaction.id,
        );

      emit(
        state.copyWith(
          transactionsByMonth: transactionsByMonth,
          recentTransactions: recentTransactions,
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

  TransactionsByMonth _removeTransaction(
    Transaction transaction, {
    required TransactionsByMonth transactionsByMonth,
  }) {
    final key = transaction.monthKey;
    final transactions = List.of(transactionsByMonth[key]!);

    transactions.removeWhere(
      (trx) => trx.id == transaction.id,
    );

    transactionsByMonth[key] = transactions;

    return transactionsByMonth;
  }

  @override
  Future<void> close() {
    _trxSubscription?.cancel();

    return super.close();
  }
}
