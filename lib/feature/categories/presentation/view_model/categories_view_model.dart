import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_color.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_icon.dart';
import 'package:expense_tracker/feature/categories/data/model/category_typedefs.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/data/model/input/update_category_input.dart';
import 'package:expense_tracker/feature/categories/data/repository/category_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesViewModel extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesViewModel(this._repository) : super(const CategoriesState()) {
    on<CategoriesStreamInitialized>(_onStreamInitialized);
    on<CategoriesRequested>(_onRequested);
    on<CategoriesItemUpdated>(_onCategoryUpdated);
    on<CategoriesItemDeleted>(_onCategoryDeleted);
  }

  final CategoryRepositoryInterface _repository;

  StreamSubscription<CategoryStreamOutput>? _categorySubscription;

  void _onStreamInitialized(_, __) {
    _categorySubscription = _repository.categoryStream.listen(
      // Refresh list once changes are made.
      (_) => add(const CategoriesRequested()),
    );
  }

  Future<void> _onRequested(
    CategoriesRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final categories = await _repository.getCategories();

      final categoriesMap = {
        for (final category in categories) category.id: category,
      };

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          categories: categories,
          categoriesMap: categoriesMap,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onCategoryUpdated(
    CategoriesItemUpdated event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      await _repository.updateCategory(
        UpdateCategoryInput(
          id: event.id,
          name: event.name,
          icon: event.icon,
          color: event.color,
        ),
      );

      emit(state.copyWith(status: ViewModelStatus.success));
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  Future<void> _onCategoryDeleted(
    CategoriesItemDeleted event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      await _repository.deleteCategory(event.id);

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _categorySubscription?.cancel();
    return super.close();
  }
}
