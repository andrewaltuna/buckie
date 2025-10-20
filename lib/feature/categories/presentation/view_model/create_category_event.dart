part of 'create_category_view_model.dart';

sealed class CreateCategoryEvent extends Equatable {
  const CreateCategoryEvent();

  @override
  List<Object> get props => [];
}

class CreateCategoryNameUpdated extends CreateCategoryEvent {
  const CreateCategoryNameUpdated(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class CreateCategoryIconUpdated extends CreateCategoryEvent {
  const CreateCategoryIconUpdated(this.icon);

  final CategoryIcon icon;

  @override
  List<Object> get props => [icon];
}

class CreateCategoryColorUpdated extends CreateCategoryEvent {
  const CreateCategoryColorUpdated(this.color);

  final CategoryColor color;

  @override
  List<Object> get props => [color];
}

class CreateCategorySubmitted extends CreateCategoryEvent {
  const CreateCategorySubmitted();
}
