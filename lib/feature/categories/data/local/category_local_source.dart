import 'dart:async';

import 'package:expense_tracker/feature/categories/data/exception/categories_exception.dart';
import 'package:expense_tracker/feature/categories/data/local/category_local_source_interface.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/data/model/input/create_category_input.dart';
import 'package:expense_tracker/feature/categories/data/model/input/update_category_input.dart';
import 'package:sqflite/sqflite.dart';

class CategoryLocalSource implements CategoryLocalSourceInterface {
  CategoryLocalSource(this._db);

  static const _table = 'categories';

  final Database _db;

  Future<CategoryDetails> _getCategory(String id) async {
    final result = await _db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) throw Exception('Category not found');

    return CategoryDetails.fromJson(result.first);
  }

  @override
  Future<List<CategoryDetails>> getCategories() async {
    final result = await _db.query(
      _table,
      orderBy: 'label ASC',
    );

    return List.generate(
      result.length,
      (i) => CategoryDetails.fromJson(result[i]),
    );
  }

  @override
  Future<CategoryDetails> createCategory(CreateCategoryInput input) async {
    final id = await _db.insert(
      _table,
      input.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final category = await _getCategory(id.toString());

    return category;
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<CategoryDetails> updateCategory(UpdateCategoryInput input) async {
    try {
      await _db.update(
        _table,
        input.toJson(),
        where: 'id = ?',
        whereArgs: [input.id],
      );

      final category = await _getCategory(input.id);

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
}
