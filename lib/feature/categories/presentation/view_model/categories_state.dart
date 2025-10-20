part of 'categories_view_model.dart';

class CategoriesState extends Equatable {
  const CategoriesState({
    this.status = ViewModelStatus.initial,
    this.categories = const [],
    this.categoriesMap = const {},
    this.error,
  });

  final ViewModelStatus status;
  final List<CategoryDetails> categories;
  final Map<int, CategoryDetails> categoriesMap;
  final Exception? error;

  CategoriesState copyWith({
    ViewModelStatus? status,
    List<CategoryDetails>? categories,
    Map<int, CategoryDetails>? categoriesMap,
    Exception? error,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      categoriesMap: categoriesMap ?? this.categoriesMap,
      error: error ?? this.error,
    );
  }

  CategoryDetails? categoryWithId(int id) {
    return categoriesMap[id];
  }

  List<CategoryDetails> get defaultCategories =>
      categories.where((cat) => cat.isDefault).toList();

  List<CategoryDetails> get customCategories =>
      categories.where((cat) => !cat.isDefault).toList();

  CategoryDetails get fallback =>
      categoriesMap[CategoryDetails.fallbackId] ?? CategoryDetails.fallback;

  @override
  List<Object?> get props => [
        status,
        categories,
        error,
      ];
}
