import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_color.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_icon.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/data/model/input/create_category_input.dart';
import 'package:expense_tracker/feature/categories/data/model/input/update_category_input.dart';
import 'package:expense_tracker/feature/categories/data/repository/category_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesViewModel extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesViewModel(this._repository) : super(const CategoriesState()) {
    on<CategoriesRequested>(_onRequested);
    on<CategoriesItemCreated>(_onCategoryCreated);
    on<CategoriesItemUpdated>(_onCategoryUpdated);
    on<CategoriesItemDeleted>(_onCategoryDeleted);
  }

  final CategoryRepositoryInterface _repository;

  Future<void> _onRequested(
    CategoriesRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final categories = await _repository.getCategories();

      print(categories);

      emit(
        state.copyWith(
          status: ViewModelStatus.loaded,
          categories: categories,
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

  Future<void> _onCategoryCreated(
    CategoriesItemCreated event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      await _repository.createCategory(
        CreateCategoryInput(
          name: event.name,
          icon: event.icon,
          color: event.color,
        ),
      );

      emit(state.copyWith(status: ViewModelStatus.loaded));
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

      emit(state.copyWith(status: ViewModelStatus.loaded));
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

      final categories = List.of(state.categories)
        ..removeWhere(
          (element) => element.id == event.id,
        );

      emit(
        state.copyWith(
          categories: categories,
          status: ViewModelStatus.loaded,
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
}
