import 'package:expense_tracker/categories/screens/categories_screen.dart';
import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/helpers/navigation_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: DashboardScreen.routeName,
      routes: [
        GoRoute(
          path: DashboardScreen.routeName,
          // builder: (context, state) => const DashboardScreen(),
          pageBuilder: (context, state) =>
              NavigationHelper.of(context).buildPageWithDefaultTransition(
            state: state,
            child: const DashboardScreen(),
          ),
        ),
        GoRoute(
          path: CategoriesScreen.routeName,
          pageBuilder: (context, state) =>
              NavigationHelper.of(context).buildPageWithDefaultTransition(
            state: state,
            child: const CategoriesScreen(),
          ),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Expense Tracker',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: Constants.fontFamilySecondary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.dashboardBackground,
        ),
      ),
      routerConfig: router,
    );

    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        fontFamily: Constants.fontFamilySecondary,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}
