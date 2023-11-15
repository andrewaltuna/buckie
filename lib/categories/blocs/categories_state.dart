part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  const CategoriesState({
    this.categories = const [],
  });

  final List<BudgetCategory> categories;

  CategoriesState copyWith({
    List<BudgetCategory>? categories,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
    );
  }

  List<Transaction> get transactions {
    return categories
        .map((category) => category.transactions)
        .expand((transactions) => transactions)
        .toList()
      ..sort((trx1, trx2) {
        return trx1.dateCreated.compareTo(trx2.dateCreated);
      });
  }

  double get allBalanceTotal {
    return categories.fold(0, (previousValue, category) {
      return previousValue + category.balance;
    });
  }

  double get allBudgetTotal {
    return categories.fold(0, (previousValue, category) {
      return previousValue + category.budget;
    });
  }

  String get allBalanceTotalDisplay => Formatter.formatNum(allBalanceTotal);
  String get allBudgetTotalDisplay => Formatter.formatNum(allBudgetTotal);

  @override
  List<Object> get props => [
        categories,
      ];
}
