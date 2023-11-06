import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'budget_usage_display_state.dart';

class BudgetUsageDisplayCubit extends Cubit<BudgetUsageDisplayState> {
  BudgetUsageDisplayCubit() : super(const BudgetUsageDisplayState());

  void changeSelection(int index) {
    emit(BudgetUsageDisplayState(selectedIndex: index));
  }
}
