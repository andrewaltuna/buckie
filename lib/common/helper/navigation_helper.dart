import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationHelper {
  const NavigationHelper._();

  static CustomTransitionPage pageWithDefaultTransition<T>({
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

  // TODO: fix implementation
  static CustomTransitionPage pageWithSlidingTransition<T>({
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
