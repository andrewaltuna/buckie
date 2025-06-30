import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:expense_tracker/feature/budget/data/model/input/set_budget_input.dart';
import 'package:expense_tracker/feature/budget/data/repository/budget_repository_interface.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'budgets_event.dart';
part 'budgets_state.dart';

class BudgetsViewModel extends Bloc<BudgetsEvent, BudgetsState> {
  BudgetsViewModel(this._repository) : super(const BudgetsState()) {
    on<BudgetsRequested>(_onRequested);
    on<BudgetsLatestRequested>(_onLatestRequested);
    on<BudgetsSet>(_onSet);
  }

  final BudgetRepositoryInterface _repository;

  Future<void> _onLatestRequested(
    BudgetsLatestRequested event,
    Emitter<BudgetsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final budget = await _repository.getLatestBudget();

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          latestBudget: budget?.amount,
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

  Future<void> _onRequested(
    BudgetsRequested event,
    Emitter<BudgetsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final budget = await _repository.getBudget(event.month);

      final budgetsByMonth = Map.of(state.budgetsByMonth)
        ..[event.month.key] = budget?.amount;

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          budgetsByMonth: budgetsByMonth,
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

  Future<void> _onSet(
    BudgetsSet event,
    Emitter<BudgetsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      await _repository.setBudget(
        SetBudgetInput(
          month: event.month,
          amount: event.amount,
        ),
      );

      final budgetsByMonth = Map.of(state.budgetsByMonth);

      if (event.amount > 0) {
        // Add/update budget
        budgetsByMonth[event.month.key] = event.amount;
      } else {
        // Delete budget
        budgetsByMonth[event.month.key] = null;
      }

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          budgetsByMonth: budgetsByMonth,
          latestBudget: event.amount > 0 ? event.amount : null,
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
