part of 'categories_view_model.dart';

class CategoriesState extends Equatable {
  const CategoriesState({
    this.categories = const [],
  });

  final List<TransactionCategory> categories;

  CategoriesState copyWith({
    List<TransactionCategory>? categories,
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
        return trx1.date.compareTo(trx2.date);
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

  String get allBalanceTotalDisplay => Formatter.currency(allBalanceTotal);
  String get allBudgetTotalDisplay => Formatter.currency(allBudgetTotal);

  @override
  List<Object> get props => [
        categories,
      ];
}
