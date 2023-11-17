import 'package:expense_tracker/account/presentation/view_model/registration_view_model.dart';
import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/component/text_field/rounded_text_field.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class RegistrationScreen extends HookWidget {
  const RegistrationScreen({super.key});

  static const routeName = 'register';

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfirmationController = useTextEditingController();

    return BlocProvider(
      create: (_) => RegistrationViewModel(),
      child: _RegisterScreen(
        emailController: emailController,
        passwordController: passwordController,
        passwordConfirmationController: passwordConfirmationController,
      ),
    );
  }
}

class _RegisterScreen extends StatelessWidget {
  const _RegisterScreen({
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmationController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;

  void resetForm() {
    emailController.clear();
    passwordController.clear();
    passwordConfirmationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Registration',
      showAppBar: true,
      showBackButton: true,
      showNavBar: false,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/logo.png',
                  height: 35,
                ),
                const SizedBox(height: 50),
                RoundedTextField(
                  label: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  icon: const Icon(
                    Icons.email,
                    color: AppColors.accent,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 8),
                RoundedTextField(
                  label: 'Password',
                  controller: passwordController,
                  obscureText: true,
                  icon: const Icon(
                    Icons.key,
                    color: AppColors.accent,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 8),
                RoundedTextField(
                  label: 'Confirm password',
                  controller: passwordConfirmationController,
                  obscureText: true,
                  icon: const Icon(
                    Icons.key,
                    color: AppColors.accent,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 50),
                const _RegisterButton(),
                const SizedBox(height: 15),
                const _LoginCTA()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginCTA extends StatelessWidget {
  const _LoginCTA();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyles.body,
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Text(
            'Login',
            style: TextStyles.body.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
        ),
      ],
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: AppColors.accent,
        ),
        child: const Text(
          'Register',
          style: TextStyles.buttonPrimary,
        ),
      ),
    );
  }
}
