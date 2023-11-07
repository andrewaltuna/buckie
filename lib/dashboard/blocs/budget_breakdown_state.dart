part of 'budget_breakdown_cubit.dart';

class BudgetBreakdownState extends Equatable {
  const BudgetBreakdownState({
    this.selectedIndex = -1,
    this.showRemaining = false,
  });

  final int selectedIndex;
  final bool showRemaining;

  BudgetBreakdownState copyWith({
    int? selectedIndex,
    bool? showRemaining,
  }) {
    return BudgetBreakdownState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      showRemaining: showRemaining ?? this.showRemaining,
    );
  }

  @override
  List<Object> get props => [
        selectedIndex,
        showRemaining,
      ];
}
