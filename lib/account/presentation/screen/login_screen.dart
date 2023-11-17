import 'package:expense_tracker/account/presentation/screen/registration_screen.dart';
import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/component/text_field/rounded_text_field.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      showAppBar: false,
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
                const RoundedTextField(
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  icon: Icon(
                    Icons.email,
                    color: AppColors.accent,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 8),
                const RoundedTextField(
                  label: 'Password',
                  obscureText: true,
                  icon: Icon(
                    Icons.key,
                    color: AppColors.accent,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 50),
                const _LoginButton(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyles.body,
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        print('Sign Up');
                        // context.go(
                        //   '${LoginScreen.routeName}/${RegisterScreen.routeName}',
                        // );
                        context.pushNamed(RegistrationScreen.routeName);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyles.body.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
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
          'Login',
          style: TextStyles.buttonPrimary,
        ),
      ),
    );
  }
}
