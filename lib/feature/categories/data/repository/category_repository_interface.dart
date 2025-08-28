import 'package:expense_tracker/feature/categories/data/model/category_typedefs.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/data/model/input/create_category_input.dart';
import 'package:expense_tracker/feature/categories/data/model/input/update_category_input.dart';

abstract interface class CategoryRepositoryInterface {
  Stream<CategoryStreamOutput> get categoryStream;

  Future<List<CategoryDetails>> getCategories({bool? customOnly});

  Future<CategoryDetails> createCategory(CreateCategoryInput input);

  Future<CategoryDetails> updateCategory(UpdateCategoryInput input);

  Future<void> deleteCategory(int id);
}
