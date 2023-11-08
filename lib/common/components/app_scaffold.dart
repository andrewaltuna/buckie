import 'package:expense_tracker/categories/screens/categories_screen.dart';
import 'package:expense_tracker/common/components/app_navigation_bar.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
  });

  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    // TODO: Revise navigation
    final path =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    final currentIndex = switch (path) {
      DashboardScreen.routeName => 0,
      CategoriesScreen.routeName => 1,
      _ => -1,
    };

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            title,
            style: TextStyles.title,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: floatingActionButton,
      body: body,
      bottomNavigationBar: const AppNavigationBar(),
      extendBody: true,
    );
  }
}
