import 'package:expense_tracker/feature/categories/presentation/screen/categories_screen.dart';
import 'package:expense_tracker/feature/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:expense_tracker/feature/settings/presentation/screen/settings_screen.dart';
import 'package:expense_tracker/feature/transactions/presentation/screen/transactions_screen.dart';
import 'package:flutter/material.dart';

enum NavigationItemType {
  none,
  dashboard,
  categories,
  transactions,
  settings,
  create;

  String get label {
    return switch (this) {
      dashboard => 'Dashboard',
      categories => 'Categories',
      transactions => 'Transactions',
      settings => 'Settings',
      _ => '',
    };
  }

  String get routeName {
    return switch (this) {
      dashboard => DashboardScreen.routeName,
      categories => CategoriesScreen.routeName,
      transactions => TransactionsScreen.routeName,
      settings => SettingsScreen.routeName,
      _ => '/',
    };
  }

  String get routePath {
    return switch (this) {
      dashboard => DashboardScreen.routePath,
      categories => CategoriesScreen.routePath,
      transactions => TransactionsScreen.routePath,
      settings => SettingsScreen.routePath,
      _ => '/',
    };
  }

  IconData get defaultIcon {
    return switch (this) {
      dashboard => Icons.home_outlined,
      categories => Icons.library_books_outlined,
      transactions => Icons.receipt_outlined,
      settings => Icons.settings_outlined,
      _ => Icons.abc_outlined,
    };
  }

  IconData get selectedIcon {
    return switch (this) {
      dashboard => Icons.home,
      categories => Icons.library_books,
      transactions => Icons.receipt,
      settings => Icons.settings,
      _ => Icons.abc,
    };
  }
}
