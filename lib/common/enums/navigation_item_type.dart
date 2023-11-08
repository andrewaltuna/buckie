import 'package:expense_tracker/categories/screens/categories_screen.dart';
import 'package:expense_tracker/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

enum NavigationItemType {
  none,
  dashboard,
  categories;

  String get label {
    return switch (this) {
      NavigationItemType.dashboard => 'Dashboard',
      NavigationItemType.categories => 'Categories',
      _ => throw Exception('Invalid type $this'),
    };
  }

  String get routeName {
    return switch (this) {
      NavigationItemType.dashboard => DashboardScreen.routeName,
      NavigationItemType.categories => CategoriesScreen.routeName,
      _ => throw Exception('Invalid type $this'),
    };
  }

  IconData get defaultIcon {
    return switch (this) {
      NavigationItemType.dashboard => Icons.home_outlined,
      NavigationItemType.categories => Icons.library_books_outlined,
      _ => throw Exception('Invalid type $this'),
    };
  }

  IconData get selectedIcon {
    return switch (this) {
      NavigationItemType.dashboard => Icons.home,
      NavigationItemType.categories => Icons.library_books,
      _ => throw Exception('Invalid type $this'),
    };
  }
}
