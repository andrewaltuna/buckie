import 'package:equatable/equatable.dart';
import 'package:expense_tracker/common/extension/enum_extension.dart';
import 'package:expense_tracker/common/extension/json_extension.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_color.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_icon.dart';

class CategoryDetails extends Equatable {
  const CategoryDetails({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.isDefault,
  });

  const CategoryDetails.defaultCategory({
    required String name,
    required CategoryIcon icon,
    required CategoryColor color,
  }) : this(
          id: -1,
          name: name,
          icon: icon,
          color: color,
          isDefault: true,
        );

  static const fallbackId = 1;
  static const fallback = _kFallbackCategory;

  // Used for populating DB with default categories
  static const defaultCategories = _kDefaultCategories;

  factory CategoryDetails.fromJson(
    Map<String, dynamic> json, {
    String prefix = '',
  }) {
    final id = json.tryParseInt('${prefix}id');

    if (id == null) return fallback;

    return CategoryDetails(
      id: id,
      name: json.parseString('${prefix}name'),
      icon: CategoryIcon.values.fromValue(
        json.parseString('${prefix}icon'),
        orElse: CategoryIcon.other,
      ),
      color: CategoryColor.values.fromValue(
        json.parseString('${prefix}color'),
        orElse: CategoryColor.darkGray,
      ),
      isDefault: json.parseBool('${prefix}is_default'),
    );
  }

  final int id;
  final String name;
  final CategoryIcon icon;
  final CategoryColor color;
  final bool isDefault;

  Map<String, dynamic> toJson({
    bool withId = true,
  }) {
    return {
      if (withId) 'id': id,
      'name': name,
      'icon': icon.value,
      'color': color.value,
      'is_default': isDefault ? 1 : 0,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        icon,
        color,
        isDefault,
      ];
}

const _kFallbackCategory = CategoryDetails.defaultCategory(
  name: 'Other',
  icon: CategoryIcon.other,
  color: CategoryColor.darkGray,
);

const _kDefaultCategories = [
  _kFallbackCategory,
  CategoryDetails.defaultCategory(
    name: 'Clothing',
    icon: CategoryIcon.clothing,
    color: CategoryColor.purple,
  ),
  CategoryDetails.defaultCategory(
    name: 'Date',
    icon: CategoryIcon.date,
    color: CategoryColor.red,
  ),
  CategoryDetails.defaultCategory(
    name: 'Education',
    icon: CategoryIcon.education,
    color: CategoryColor.blue,
  ),
  CategoryDetails.defaultCategory(
    name: 'Entertainment',
    icon: CategoryIcon.entertainment,
    color: CategoryColor.pink,
  ),
  CategoryDetails.defaultCategory(
    name: 'Food',
    icon: CategoryIcon.food,
    color: CategoryColor.orange,
  ),
  CategoryDetails.defaultCategory(
    name: 'Gift',
    icon: CategoryIcon.gift,
    color: CategoryColor.red,
  ),
  CategoryDetails.defaultCategory(
    name: 'Groceries',
    icon: CategoryIcon.groceries,
    color: CategoryColor.teal,
  ),
  CategoryDetails.defaultCategory(
    name: 'Health',
    icon: CategoryIcon.health,
    color: CategoryColor.magenta,
  ),
  CategoryDetails.defaultCategory(
    name: 'Transport',
    icon: CategoryIcon.transport,
    color: CategoryColor.cyan,
  ),
  CategoryDetails.defaultCategory(
    name: 'Travel',
    icon: CategoryIcon.travel,
    color: CategoryColor.green,
  ),
  CategoryDetails.defaultCategory(
    name: 'Utilities',
    icon: CategoryIcon.utilities,
    color: CategoryColor.gray,
  ),
];
