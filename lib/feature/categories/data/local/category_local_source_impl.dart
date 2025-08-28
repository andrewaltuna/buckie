import 'dart:async';

import 'package:expense_tracker/feature/categories/data/exception/categories_exception.dart';
import 'package:expense_tracker/feature/categories/data/local/category_local_source.dart';
import 'package:expense_tracker/feature/categories/data/model/category_typedefs.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/data/model/input/create_category_input.dart';
import 'package:expense_tracker/feature/categories/data/model/input/update_category_input.dart';
import 'package:sqflite/sqflite.dart';

class CategoryLocalSourceImpl implements CategoryLocalSource {
  CategoryLocalSourceImpl(this._db);

  static const _table = 'categories';

  final Database _db;

  final _streamController = StreamController<CategoryStreamOutput>.broadcast();

  @override
  Stream<CategoryStreamOutput> get categoryStream => _streamController.stream;

  Future<CategoryDetails> _getCategory(int id) async {
    final result = await _db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) throw Exception('Category not found');

    return CategoryDetails.fromJson(result.first);
  }

  @override
  Future<List<CategoryDetails>> getCategories([bool? customOnly]) async {
    final result = customOnly == null
        ? await _db.query(
            _table,
            orderBy: 'name ASC',
          )
        : await _db.query(
            _table,
            orderBy: 'name ASC',
            where: 'is_default = ?',
            whereArgs: [customOnly ? 0 : 1],
          );

    return List.generate(
      result.length,
      (i) => CategoryDetails.fromJson(result[i]),
    );
  }

  @override
  Future<CategoryDetails> createCategory(CreateCategoryInput input) async {
    try {
      final id = await _db.insert(
        _table,
        input.toJson(),
      );

      final category = await _getCategory(id);

      _streamController.add(
        CategoryStreamOutput.insert(
          category,
        ),
      );

      return category;
    } catch (error) {
      if (error is DatabaseException) {
        if (error.isUniqueConstraintError()) {
          throw const CategoriesDuplicateException();
        }
      }

      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(int id) async {
    final category = await _getCategory(id);

    await _db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    _streamController.add(
      CategoryStreamOutput.delete(category),
    );
  }

  @override
  Future<CategoryDetails> updateCategory(UpdateCategoryInput input) async {
    try {
      final oldCategory = await _getCategory(input.id);

      await _db.update(
        _table,
        input.toJson(),
        where: 'id = ?',
        whereArgs: [input.id],
      );

      final newCategory = await _getCategory(input.id);

      _streamController.add(
        CategoryStreamOutput.update(
          oldCategory,
          newCategory,
        ),
      );

      return newCategory;
    } catch (error) {
      if (error is DatabaseException) {
        if (error.isUniqueConstraintError()) {
          throw const CategoriesDuplicateException();
        }
      }

      rethrow;
    }
  }
}
