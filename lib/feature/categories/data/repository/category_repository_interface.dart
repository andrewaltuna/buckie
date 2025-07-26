import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/data/model/input/create_category_input.dart';
import 'package:expense_tracker/feature/categories/data/model/input/update_category_input.dart';

abstract interface class CategoryRepositoryInterface {
  Future<List<CategoryDetails>> getCategories();

  Future<CategoryDetails> createCategory(CreateCategoryInput input);

  Future<CategoryDetails> updateCategory(UpdateCategoryInput input);

  Future<void> deleteCategory(String id);
}
