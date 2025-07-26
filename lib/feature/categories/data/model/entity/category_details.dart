import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/extension/enum_extension.dart';
import 'package:expense_tracker/common/extension/json_extension.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_color.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_icon.dart';

class CategoryDetails extends Equatable {
  const CategoryDetails({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });

  static const fallbackId = _kFallbackCategoryId;
  static const fallback = _kFallbackCategory;

  static const defaultCategories = _kDefaultCategories;

  factory CategoryDetails.fromJson(
    Map<String, dynamic> json, {
    String prefix = '',
  }) {
    final id = json.parseString('${prefix}id');

    // Check if id is not an int (for default categories)
    if (int.tryParse(id) == null) {
      return defaultCategories.firstWhere(
        (category) => category.id == id,
      );
    }

    return CategoryDetails(
      id: id,
      label: json.parseString('${prefix}label'),
      icon: CategoryIcon.values.fromValue(
        json.parseString('${prefix}icon'),
        orElse: CategoryIcon.other,
      ),
      color: CategoryColor.values.fromValue(
        json.parseString('${prefix}color'),
        orElse: CategoryColor.darkGray,
      ),
    );
  }

  final String id;
  final String label;
  final CategoryIcon icon;
  final CategoryColor color;

  @override
  List<Object?> get props => [
        id,
        label,
        icon,
        color,
      ];
}

const _kDefaultCategories = [
  CategoryDetails(
    id: 'clothing',
    label: 'Clothing',
    icon: CategoryIcon.clothing,
    color: CategoryColor.purple,
  ),
  CategoryDetails(
    id: 'date',
    label: 'Date',
    icon: CategoryIcon.date,
    color: CategoryColor.red,
  ),
  CategoryDetails(
    id: 'education',
    label: 'Education',
    icon: CategoryIcon.education,
    color: CategoryColor.blue,
  ),
  CategoryDetails(
    id: 'entertainment',
    label: 'Entertainment',
    icon: CategoryIcon.entertainment,
    color: CategoryColor.pink,
  ),
  CategoryDetails(
    id: 'food',
    label: 'Food',
    icon: CategoryIcon.food,
    color: CategoryColor.orange,
  ),
  CategoryDetails(
    id: 'gift',
    label: 'Gift',
    icon: CategoryIcon.gift,
    color: CategoryColor.red,
  ),
  CategoryDetails(
    id: 'groceries',
    label: 'Groceries',
    icon: CategoryIcon.groceries,
    color: CategoryColor.teal,
  ),
  CategoryDetails(
    id: 'health',
    label: 'Health',
    icon: CategoryIcon.health,
    color: CategoryColor.magenta,
  ),
  CategoryDetails(
    id: 'transport',
    label: 'Transport',
    icon: CategoryIcon.transport,
    color: CategoryColor.cyan,
  ),
  CategoryDetails(
    id: 'travel',
    label: 'Travel',
    icon: CategoryIcon.travel,
    color: CategoryColor.green,
  ),
  CategoryDetails(
    id: 'utilities',
    label: 'Utilities',
    icon: CategoryIcon.utilities,
    color: CategoryColor.gray,
  ),
  _kFallbackCategory,
];

const _kFallbackCategory = CategoryDetails(
  id: _kFallbackCategoryId,
  label: 'Other',
  icon: CategoryIcon.other,
  color: CategoryColor.darkGray,
);

const _kFallbackCategoryId = 'other';
