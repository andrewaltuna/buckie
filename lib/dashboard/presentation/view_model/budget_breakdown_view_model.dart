import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'budget_breakdown_state.dart';

class BudgetBreakdownViewModel extends Cubit<BudgetBreakdownState> {
  BudgetBreakdownViewModel() : super(const BudgetBreakdownState());

  void changeSelection(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void toggleShowRemaining() {
    emit(state.copyWith(showRemaining: !state.showRemaining));
  }
}
