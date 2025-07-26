import 'package:expense_tracker/feature/categories/data/local/category_local_source_interface.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/data/model/input/create_category_input.dart';
import 'package:expense_tracker/feature/categories/data/model/input/update_category_input.dart';
import 'package:expense_tracker/feature/categories/data/repository/category_repository_interface.dart';

class CategoryRepository implements CategoryRepositoryInterface {
  const CategoryRepository(this._localSource);

  final CategoryLocalSourceInterface _localSource;

  @override
  Future<List<CategoryDetails>> getCategories() {
    return _localSource.getCategories();
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
  Future<void> deleteCategory(String id) {
    return _localSource.deleteCategory(id);
  }
}
