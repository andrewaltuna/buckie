import 'package:expense_tracker/common/navigation/app_router.dart';
import 'package:expense_tracker/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalListeners extends StatelessWidget {
  const GlobalListeners({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthViewModel, AuthState>(
          listenWhen: (previous, current) =>
              previous.isAuthenticated != current.isAuthenticated,
          listener: (_, __) => AppNavigation.router.refresh(),
        ),
      ],
      child: child,
    );
  }
}
