import 'package:expense_tracker/common/global/authenticated_view_models.dart';
import 'package:expense_tracker/common/helper/navigation_helper.dart';
import 'package:expense_tracker/feature/account/presentation/screen/login_screen.dart';
import 'package:expense_tracker/feature/account/presentation/screen/registration_screen.dart';
import 'package:expense_tracker/feature/categories/presentation/screen/categories_screen.dart';
import 'package:expense_tracker/feature/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:expense_tracker/feature/settings/presentation/screen/settings_screen.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/presentation/screen/create_transaction_screen.dart';
import 'package:expense_tracker/feature/transactions/presentation/screen/transactions_screen.dart';
import 'package:expense_tracker/feature/transactions/presentation/screen/update_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  const AppNavigation._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static const authRoutes = [
    LoginScreen.routePath,
    RegistrationScreen.routePath,
  ];

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: DashboardScreen.routePath,
    // TEMP disregard auth
    /* redirect: (context, state) {
      final path = state.fullPath;
      final isAuthRoute = authRoutes.contains(path);

      final authState = context.read<AuthViewModel>().state;
      final isAuthenticated =
          authState.status.isLoaded && authState.isAuthenticated;

      // Redirect to dashboard if authenticated and attempting to access auth screens.
      if (isAuthRoute && isAuthenticated) return DashboardScreen.routePath;

      // Redirect to login not authenticated and attempting to access main screens.
      if (!isAuthRoute && !isAuthenticated) return LoginScreen.routePath;

      return null;
    }, */
    routes: [
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routePath,
        pageBuilder: (context, state) {
          return NavigationHelper.of(context).pageWithDefaultTransition(
            state: state,
            child: const LoginScreen(),
          );
        },
      ),
      GoRoute(
        name: RegistrationScreen.routeName,
        path: RegistrationScreen.routePath,
        pageBuilder: (context, state) =>
            NavigationHelper.of(context).pageWithDefaultTransition(
          state: state,
          child: const RegistrationScreen(),
        ),
      ),
      ShellRoute(
        builder: (_, __, child) => AuthenticatedViewModels(
          child: child,
        ),
        routes: [
          GoRoute(
            name: DashboardScreen.routeName,
            path: DashboardScreen.routePath,
            pageBuilder: (context, state) =>
                NavigationHelper.of(context).pageWithDefaultTransition(
              state: state,
              child: const DashboardScreen(),
            ),
          ),
          GoRoute(
            name: CategoriesScreen.routeName,
            path: CategoriesScreen.routePath,
            pageBuilder: (context, state) =>
                NavigationHelper.of(context).pageWithDefaultTransition(
              state: state,
              child: const CategoriesScreen(),
            ),
          ),
          GoRoute(
            name: TransactionsScreen.routeName,
            path: TransactionsScreen.routePath,
            pageBuilder: (context, state) =>
                NavigationHelper.of(context).pageWithDefaultTransition(
              state: state,
              child: const TransactionsScreen(),
            ),
          ),
          GoRoute(
            name: CreateTransactionScreen.routeName,
            path: CreateTransactionScreen.routePath,
            pageBuilder: (context, state) =>
                NavigationHelper.of(context).pageWithDefaultTransition(
              state: state,
              child: const CreateTransactionScreen(),
            ),
          ),
          GoRoute(
            name: UpdateTransactionScreen.routeName,
            path: UpdateTransactionScreen.routePath,
            pageBuilder: (context, state) =>
                NavigationHelper.of(context).pageWithDefaultTransition(
              state: state,
              child: UpdateTransactionScreen(
                transaction: state.extra! as Transaction,
              ),
            ),
          ),
          GoRoute(
            name: SettingsScreen.routeName,
            path: SettingsScreen.routePath,
            pageBuilder: (context, state) =>
                NavigationHelper.of(context).pageWithDefaultTransition(
              state: state,
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
