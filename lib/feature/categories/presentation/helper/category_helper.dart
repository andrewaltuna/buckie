import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/presentation/view_model/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryHelper {
  const CategoryHelper._(this._context);

  factory CategoryHelper.of(BuildContext context) => CategoryHelper._(context);

  final BuildContext _context;

  CategoryDetails watchCategoryWithId(int id) {
    return _context.select(
      (CategoriesViewModel vm) =>
          vm.state.categoryWithId(id) ?? vm.state.fallback,
    );
  }

  CategoryDetails readCategoryWithId(int id) {
    final state = _context.read<CategoriesViewModel>().state;

    return state.categoryWithId(id) ?? state.fallback;
  }
}
