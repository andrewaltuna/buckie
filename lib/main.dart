import 'package:expense_tracker/account/presentation/screen/login_screen.dart';
import 'package:expense_tracker/categories/presentation/screen/categories_screen.dart';
import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/helper/navigation_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:expense_tracker/global_view_models.dart';
import 'package:expense_tracker/settings/presentation/screen/settings_screen.dart';
import 'package:expense_tracker/transactions/presentation/screen/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    const GlobalViewModels(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: LoginScreen.routeName,
      routes: [
        GoRoute(
          path: LoginScreen.routeName,
          pageBuilder: (context, state) =>
              NavigationHelper.of(context).buildPageWithDefaultTransition(
            state: state,
            child: const LoginScreen(),
          ),
        ),
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
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.fontPrimary,
            ),
      ),
      routerConfig: router,
    );
  }
}
