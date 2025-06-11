import 'package:expense_tracker/feature/account/data/exception/auth_exception.dart';
import 'package:expense_tracker/feature/account/presentation/component/form_field_icon.dart';
import 'package:expense_tracker/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:expense_tracker/feature/account/presentation/view_model/registration_form_view_model.dart';
import 'package:expense_tracker/common/component/button/rounded_button.dart';
import 'package:expense_tracker/common/component/logo.dart';
import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/component/text_field/rounded_text_field.dart';
import 'package:expense_tracker/common/enum/button_state.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class RegistrationScreen extends HookWidget {
  const RegistrationScreen({super.key});

  static const routeName = 'register';
  static const routePath = '/register';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationFormViewModel(),
      child: MainScaffold(
        title: 'Registration',
        showAppBar: false,
        showBackButton: true,
        showNavBar: false,
        body: _Body(
          emailController: useTextEditingController(),
          passwordController: useTextEditingController(),
          passwordConfirmController: useTextEditingController(),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;

  void _validationListener(BuildContext context, AuthState state) {
    if (!state.status.isError) {
      context.read<RegistrationFormViewModel>().emailErrorText('');

      return;
    }

    final error = state.error;

    if (error is AuthInvalidEmailException ||
        error is AuthEmailAlreadyInUseException) {
      context
          .read<RegistrationFormViewModel>()
          .emailErrorText(error.toString());
    }
  }

  void _onFormSubmitted(BuildContext context, bool isFormValid) {
    if (!isFormValid) return;

    context.read<AuthViewModel>().add(
          AuthRegistered(
            email: emailController.text,
            password: passwordController.text,
            passwordConfirmation: passwordConfirmController.text,
          ),
        );
  }

  void _onPasswordChanged(BuildContext context) {
    context.read<RegistrationFormViewModel>().validatePassword(
          password: passwordController.text,
          passwordConfirmation: passwordConfirmController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final formState = context.watch<RegistrationFormViewModel>().state;
    final formViewModel = context.read<RegistrationFormViewModel>();

    final authStatus = context.select(
      (AuthViewModel viewModel) => viewModel.state.status,
    );

    final isFormValid = formState.isErrorFree &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordConfirmController.text.isNotEmpty;

    return BlocListener<AuthViewModel, AuthState>(
      listener: _validationListener,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Logo(),
              const SizedBox(height: 50),
              RoundedTextField(
                controller: emailController,
                label: 'Email',
                icon: const FormFieldIcon(icon: Icons.email),
                errorText: formState.emailErrorText,
                keyboardType: TextInputType.emailAddress,
                onChanged: (_) => formViewModel.emailErrorText(''),
              ),
              const SizedBox(height: 8),
              RoundedTextField(
                controller: passwordController,
                label: 'Password',
                icon: const FormFieldIcon(icon: Icons.key),
                errorText: formState.passwordErrorText,
                obscureText: true,
                onTap: () => passwordController.clear(),
                onChanged: (_) => _onPasswordChanged(context),
              ),
              const SizedBox(height: 8),
              RoundedTextField(
                controller: passwordConfirmController,
                label: 'Confirm password',
                icon: const FormFieldIcon(icon: Icons.key),
                errorText: formState.passwordConfirmationErrorText,
                obscureText: true,
                onTap: () => passwordConfirmController.clear(),
                onChanged: (_) => _onPasswordChanged(context),
              ),
              const SizedBox(height: 50),
              _RegisterButton(
                onPressed: () => _onFormSubmitted(
                  context,
                  isFormValid,
                ),
                isLoading: authStatus.isLoading,
              ),
              const SizedBox(height: 15),
              const _LoginCTA(),
            ],
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
    required this.onPressed,
    required this.isLoading,
  });

  final Function onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      label: 'Register',
      onPressed: onPressed,
      state: isLoading ? ButtonState.loading : ButtonState.idle,
    );
  }
}
