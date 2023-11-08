import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationHelper {
  const NavigationHelper._(this._context);

  final BuildContext _context;

  factory NavigationHelper.of(BuildContext context) =>
      NavigationHelper._(context);

  CustomTransitionPage buildPageWithDefaultTransition<T>({
    required GoRouterState state,
    required Widget child,
  }) {
    const transitionDuration = Duration(milliseconds: 100);

    return CustomTransitionPage<T>(
      key: state.pageKey,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: transitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      child: child,
    );
  }
}
