import 'package:expense_tracker/feature/account/presentation/screen/registration_screen.dart';
import 'package:expense_tracker/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:expense_tracker/common/component/asset/app_images.dart';
import 'package:expense_tracker/common/component/button/rounded_button.dart';
import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/component/text_field/rounded_text_field.dart';
import 'package:expense_tracker/common/enum/button_state.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  static const routeName = 'login';
  static const routePath = '/login';

  void _accountListener(
    BuildContext context,
    AuthState state,
  ) {
    print(state.isAuthenticated);
    if (state.status.isLoading) return;

    if (state.isAuthenticated) {
      context.goNamed(DashboardScreen.routeName);
    }
  }

  void _onLoginPressed(
    BuildContext context, {
    required String email,
    required String password,
  }) {
    context.read<AuthViewModel>().add(
          AuthSignedIn(
            email: email,
            password: password,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return BlocConsumer<AuthViewModel, AuthState>(
      listener: _accountListener,
      builder: (context, state) {
        return MainScaffold(
          showAppBar: false,
          showNavBar: false,
          body: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppImages.logo.copyWith(height: 35),
                const SizedBox(height: 50),
                _EmailFormField(emailController: emailController),
                const SizedBox(height: 8),
                _PasswordFormField(passwordController: passwordController),
                const SizedBox(height: 50),
                _LoginButton(
                  isLoading: state.status.isLoading,
                  onPressed: () => _onLoginPressed(
                    context,
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                ),
                const SizedBox(height: 15),
                const _SignUpCTA(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SignUpCTA extends StatelessWidget {
  const _SignUpCTA();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyles.bodyRegular,
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            context.pushNamed(RegistrationScreen.routeName);
          },
          child: Text(
            'Sign Up',
            style: TextStyles.bodyRegular.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordFormField extends StatelessWidget {
  const _PasswordFormField({
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      label: 'Password',
      controller: passwordController,
      obscureText: true,
      icon: const Icon(
        Icons.key,
        color: AppColors.accent,
        size: 16,
      ),
    );
  }
}

class _EmailFormField extends StatelessWidget {
  const _EmailFormField({
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      label: 'Email',
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      icon: const Icon(
        Icons.email,
        color: AppColors.accent,
        size: 16,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.onPressed,
    required this.isLoading,
  });

  final Function onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      label: 'Login',
      onPressed: onPressed,
      state: isLoading ? ButtonState.loading : ButtonState.idle,
    );
  }
}
