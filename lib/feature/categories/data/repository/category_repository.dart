import 'package:expense_tracker/feature/categories/data/local/category_local_source.dart';
import 'package:expense_tracker/feature/categories/data/model/category_typedefs.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/data/model/input/create_category_input.dart';
import 'package:expense_tracker/feature/categories/data/model/input/update_category_input.dart';
import 'package:expense_tracker/feature/categories/data/repository/category_repository_interface.dart';

class CategoryRepository implements CategoryRepositoryInterface {
  const CategoryRepository(this._localSource);

  final CategoryLocalSource _localSource;

  @override
  Stream<CategoryStreamOutput> get categoryStream =>
      _localSource.categoryStream;

  @override
  Future<List<CategoryDetails>> getCategories({bool? customOnly}) {
    return _localSource.getCategories(customOnly);
  }

  @override
  Future<CategoryDetails> createCategory(CreateCategoryInput input) {
    return _localSource.createCategory(input);
  }

  @override
  Future<CategoryDetails> updateCategory(UpdateCategoryInput input) {
    return _localSource.updateCategory(input);
  }

  @override
  Future<void> deleteCategory(int id) {
    return _localSource.deleteCategory(id);
  }
}
