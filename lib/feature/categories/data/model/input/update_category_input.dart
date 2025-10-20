import 'package:expense_tracker/common/extension/enum_extension.dart';
import 'package:expense_tracker/feature/categories/data/model/input/create_category_input.dart';

class UpdateCategoryInput extends CreateCategoryInput {
  const UpdateCategoryInput({
    required this.id,
    required super.name,
    required super.icon,
    required super.color,
  });

  final int id;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon.value,
      'color': color.value,
    };
  }
}
