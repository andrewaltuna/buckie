part of 'categories_view_model.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class CategoriesLoaded extends CategoriesEvent {}
