import 'dart:async';

import 'package:collection/collection.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:expense_tracker/feature/budget/data/model/output/budget.dart';
import 'package:expense_tracker/feature/budget/data/repository/budget_repository_interface.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/output/transaction_stream_output.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesViewModel extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesViewModel(
    this._transactionRepository,
    this._budgetRepository,
  ) : super(const CategoriesState()) {
    on<CategoriesRequested>(_onLoaded);

    _trxSubscription = _transactionRepository.transactionsStream.listen(
      (output) {
        final month = output.transaction.month;
        final stateMonth = state.budget?.month;

        if (stateMonth == null) return;

        if (stateMonth != month) return;

        // Refresh if month is null (signifies deleted trx)
        // or if month matches updated month
        add(CategoriesRequested(stateMonth));
      },
    );

    _budgetSubscription = _budgetRepository.budgetStream.listen(
      (budget) {
        final stateMonth = state.budget?.month;

        if (stateMonth == null) return;

        if (stateMonth != budget.month) return;

        // Refresh if month is null (signifies deleted budget)
        // or if month matches updated month
        add(CategoriesRequested(stateMonth));
      },
    );
  }

  final TransactionRepositoryInterface _transactionRepository;
  final BudgetRepositoryInterface _budgetRepository;

  StreamSubscription<TransactionStreamOutput>? _trxSubscription;
  StreamSubscription<Budget>? _budgetSubscription;

  Future<void> _onLoaded(
    CategoriesRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final result = await Future.wait([
        _transactionRepository.getTransactions(month: event.month),
        _budgetRepository.getBudget(event.month),
      ]);

      final transactions = result[0] as List<Transaction>;
      final categories = _transactionsToCategories(transactions);

      final budget = result[1] as Budget?;

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          categories: categories,
          budget: budget,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          error: error,
          status: ViewModelStatus.error,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    _trxSubscription?.cancel();
    _budgetSubscription?.cancel();
    super.close();
  }
}

List<Category> _transactionsToCategories(
  List<Transaction> transactions,
) {
  final trxByCatgegory = groupBy(
    transactions,
    (transaction) => transaction.category,
  );

  final categories = trxByCatgegory.entries.map((entry) {
    return Category(
      type: entry.key,
      totalExpense: entry.value.fold(
        0,
        (previous, transaction) => previous + transaction.amount,
      ),
    );
  }).toList();

  return categories
    ..sort(
      (a, b) => b.totalExpense.compareTo(a.totalExpense),
    );
}
