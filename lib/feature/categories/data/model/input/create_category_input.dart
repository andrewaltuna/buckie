import 'package:expense_tracker/common/extension/enum_extension.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_color.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_icon.dart';

class CreateCategoryInput {
  const CreateCategoryInput({
    required this.name,
    required this.icon,
    required this.color,
  });

  final String name;
  final CategoryIcon icon;
  final CategoryColor color;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon.value,
      'color': color.value,
      'is_default': 0,
    };
  }
}
