part of 'categories_view_model.dart';

class CategoriesState extends Equatable {
  const CategoriesState({
    this.status = ViewModelStatus.initial,
    this.categories = const [],
    this.error,
  });

  final ViewModelStatus status;
  final List<CategoryDetails> categories;
  final Exception? error;

  CategoriesState copyWith({
    ViewModelStatus? status,
    List<CategoryDetails>? categories,
    Exception? error,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      error: error ?? this.error,
    );
  }

  CategoryDetails categoryWithId(String id) {
    final category = allCategories.firstWhereOrNull(
      (category) => category.id == id,
    );

    return category ?? CategoryDetails.fallback;
  }

  List<CategoryDetails> get allCategories => [
        ...categories,
        ...CategoryDetails.defaultCategories,
      ];

  @override
  List<Object?> get props => [
        status,
        categories,
        error,
      ];
}
