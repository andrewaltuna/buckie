part of 'create_category_view_model.dart';

class CreateCategoryState extends Equatable {
  const CreateCategoryState({
    this.status = ViewModelStatus.initial,
    this.name = '',
    this.icon = CategoryIcon.other,
    this.color = CategoryColor.yellow,
    this.error,
    this.nameError = '',
  });

  final ViewModelStatus status;
  final String name;
  final CategoryIcon icon;
  final CategoryColor color;
  final Exception? error;

  final String nameError;

  CreateCategoryState copyWith({
    ViewModelStatus? status,
    String? name,
    CategoryIcon? icon,
    CategoryColor? color,
    Exception? error,
    String? nameError,
  }) {
    return CreateCategoryState(
      status: status ?? this.status,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      error: error ?? this.error,
      nameError: nameError ?? this.nameError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        icon,
        color,
        error,
        nameError,
      ];
}
