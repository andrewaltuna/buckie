part of 'budget_usage_display_cubit.dart';

class BudgetUsageDisplayState extends Equatable {
  const BudgetUsageDisplayState({
    this.selectedIndex = -1,
  });

  final int selectedIndex;

  @override
  List<Object> get props => [
        selectedIndex,
      ];
}
