import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:expense_tracker/feature/budget/data/model/input/set_budget_input.dart';
import 'package:expense_tracker/feature/budget/data/repository/budget_repository_interface.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetViewModel extends Bloc<BudgetEvent, BudgetState> {
  BudgetViewModel(
    this._repository, {
    required TransactionMonth month,
  })  : _month = month,
        super(const BudgetState()) {
    on<BudgetRequested>(_onRequested);
    on<BudgetLatestRequested>(_onLatestRequested);
    on<BudgetSet>(_onSet);
  }

  final BudgetRepositoryInterface _repository;
  final TransactionMonth _month;

  Future<void> _onLatestRequested(
    BudgetLatestRequested event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final budget = await _repository.getLatestBudget();

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          amount: () => budget?.amount,
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
    BudgetRequested event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final budget = await _repository.getBudget(event.month ?? _month);
      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          amount: () => budget?.amount,
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
    BudgetSet event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      await _repository.setBudget(
        SetBudgetInput(
          month: _month,
          amount: event.budget,
        ),
      );

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          amount: () => event.budget,
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
