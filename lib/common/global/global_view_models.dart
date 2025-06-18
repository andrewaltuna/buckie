import 'package:expense_tracker/common/di/service_locator.dart';
import 'package:expense_tracker/feature/account/data/repository/auth_repository_interface.dart';
import 'package:expense_tracker/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalViewModels extends StatelessWidget {
  const GlobalViewModels({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthViewModel(
            sl<AuthRepositoryInterface>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
