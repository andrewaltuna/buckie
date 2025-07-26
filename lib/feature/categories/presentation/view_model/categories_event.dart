part of 'categories_view_model.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class CategoriesRequested extends CategoriesEvent {
  const CategoriesRequested();
}

class CategoriesItemCreated extends CategoriesEvent {
  const CategoriesItemCreated({
    required this.name,
    required this.icon,
    required this.color,
  });

  final String name;
  final CategoryIcon icon;
  final CategoryColor color;

  @override
  List<Object> get props => [name, icon, color];
}

class CategoriesItemUpdated extends CategoriesEvent {
  const CategoriesItemUpdated({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  // For manual updates
  final String id;
  final String name;
  final CategoryIcon icon;
  final CategoryColor color;

  @override
  List<Object?> get props => [
        id,
        name,
        icon,
        color,
      ];
}

class CategoriesItemDeleted extends CategoriesEvent {
  const CategoriesItemDeleted({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}
