import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/extension/transaction_extension.dart';
import 'package:expense_tracker/feature/transactions/data/model/transaction_typedefs.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsViewModel extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsViewModel(this._repository) : super(const TransactionsState()) {
    on<TransactionsStreamInitialized>(_onStreamInitialized);
    on<TransactionsRequested>(_onRequested);
    on<TransactionsItemUpdated>(_onItemUpdated);
    on<TransactionsItemDeleted>(_onItemDeleted);
  }

  final TransactionRepositoryInterface _repository;

  /// Used for updating [transactionsByMonth] when transactions are added/changed.
  StreamSubscription<TransactionStreamOutput>? _trxSubscription;

  void _onStreamInitialized(_, __) {
    _trxSubscription = _repository.transactionsStream.listen(
      (output) {
        final TransactionStreamOutput(
          :operation,
          :previous,
          :current,
        ) = output;

        final key = (previous ?? current)?.monthKey;

        // Only continue if transaction month is already loaded.
        if (!state.transactionsByMonth.containsKey(key)) return;

        if (operation.isDelete) {
          add(TransactionsItemDeleted(output.previous!));
        } else if (operation.isUpdate) {
          if (current == null || previous == null) return;

          add(
            TransactionsItemUpdated(
              newTransaction: current,
              oldTransaction: previous,
            ),
          );
        } else {
          if (current == null) return;

          add(
            TransactionsRequested(
              month: output.current!.month,
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
          status: ViewModelStatus.success,
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
