import 'package:expense_tracker/categories/screens/categories_screen.dart';
import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/helpers/navigation_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/dashboard/screens/dashboard_screen.dart';
import 'package:expense_tracker/global_blocs.dart';
import 'package:expense_tracker/settings/screens/settings_screen.dart';
import 'package:expense_tracker/transactions/screens/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    const GlobalBlocs(
      child: App(),
    ),
  );
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
        GoRoute(
          path: TransactionsScreen.routeName,
          pageBuilder: (context, state) =>
              NavigationHelper.of(context).buildPageWithDefaultTransition(
            state: state,
            child: const TransactionsScreen(),
          ),
        ),
        GoRoute(
          path: SettingsScreen.routeName,
          pageBuilder: (context, state) =>
              NavigationHelper.of(context).buildPageWithDefaultTransition(
            state: state,
            child: const SettingsScreen(),
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
          seedColor: AppColors.defaultBackground,
        ),
      ),
      routerConfig: router,
    );
  }
}
