import 'package:expense_tracker/common/component/main_navigation_bar.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
  });

  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            title,
            style: TextStyles.title.copyWith(
              color: AppColors.accent,
            ),
          ),
        ),
        backgroundColor: AppColors.widgetBackgroundPrimary,
      ),
      floatingActionButton: floatingActionButton,
      backgroundColor: AppColors.defaultBackground,
      bottomNavigationBar: const MainNavigationBar(),
      extendBody: true,
      body: body,
    );
  }
}
