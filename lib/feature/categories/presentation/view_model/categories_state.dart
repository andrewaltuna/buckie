part of 'categories_view_model.dart';

class CategoriesState extends Equatable {
  const CategoriesState({
    this.status = ViewModelStatus.initial,
    this.categories = const [],
    this.budget,
    this.error,
  });

  final ViewModelStatus status;
  final List<Category> categories;
  final Budget? budget;
  final Exception? error;

  CategoriesState copyWith({
    ViewModelStatus? status,
    List<Category>? categories,
    Budget? budget,
    Exception? error,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      budget: budget ?? this.budget,
      error: error ?? this.error,
    );
  }

  double get budgetAmount => budget?.amount ?? 0;

  double get grandTotalExpense => categories.fold(
        0,
        (sum, category) {
          return sum + category.expense;
        },
      );

  double? get remainingBalance =>
      budget != null ? budgetAmount - grandTotalExpense : null;

  String get remainingBalanceLabel => remainingBalance != null
      ? Formatter.currency(
          budgetAmount - grandTotalExpense,
        )
      : 'N/A';

  String get budgetLabel =>
      budget != null ? Formatter.currency(budgetAmount) : 'N/A';

  @override
  List<Object?> get props => [
        status,
        categories,
        budget,
        error,
      ];
}
