import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_color.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_icon.dart';
import 'package:expense_tracker/feature/categories/data/exception/categories_exception.dart';
import 'package:expense_tracker/feature/categories/data/model/input/create_category_input.dart';
import 'package:expense_tracker/feature/categories/data/model/input/update_category_input.dart';
import 'package:expense_tracker/feature/categories/data/repository/category_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryViewModel
    extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  CreateCategoryViewModel(
    this._repository, {
    int? categoryId,
  })  : _categoryId = categoryId,
        super(const CreateCategoryState()) {
    on<CreateCategoryNameUpdated>(_onNameUpdated);
    on<CreateCategoryIconUpdated>(_onIconUpdated);
    on<CreateCategoryColorUpdated>(_onColorUpdated);
    on<CreateCategorySubmitted>(_onSubmitted);
  }

  final CategoryRepositoryInterface _repository;
  final int? _categoryId;

  void _onNameUpdated(
    CreateCategoryNameUpdated event,
    Emitter<CreateCategoryState> emit,
  ) {
    emit(
      state.copyWith(
        name: event.name,
        nameError: '',
      ),
    );
  }

  void _onIconUpdated(
    CreateCategoryIconUpdated event,
    Emitter<CreateCategoryState> emit,
  ) {
    emit(state.copyWith(icon: event.icon));
  }

  void _onColorUpdated(
    CreateCategoryColorUpdated event,
    Emitter<CreateCategoryState> emit,
  ) {
    emit(state.copyWith(color: event.color));
  }

  Future<void> _onSubmitted(
    CreateCategorySubmitted event,
    Emitter<CreateCategoryState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      if (_categoryId != null) {
        await _repository.updateCategory(
          UpdateCategoryInput(
            id: _categoryId!,
            name: state.name.trim(),
            icon: state.icon,
            color: state.color,
          ),
        );
      } else {
        await _repository.createCategory(
          CreateCategoryInput(
            name: state.name.trim(),
            icon: state.icon,
            color: state.color,
          ),
        );
      }

      emit(state.copyWith(status: ViewModelStatus.success));
    } on Exception catch (error) {
      print(error);
      String? nameError;

      if (error is CategoriesDuplicateException) {
        nameError = error.toString();
      }

      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
          nameError: nameError,
        ),
      );
    }
  }
}
