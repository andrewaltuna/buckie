import 'package:expense_tracker/common/component/main_navigation_bar.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.body,
    this.title,
    this.showAppBar = true,
    this.showNavBar = true,
    this.floatingActionButton,
  });

  final String? title;
  final Widget body;
  final bool showAppBar;
  final bool showNavBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar && title != null
          ? AppBar(
              title: Center(
                child: Text(
                  title ?? '',
                  style: TextStyles.title.copyWith(
                    color: AppColors.accent,
                  ),
                ),
              ),
              backgroundColor: AppColors.widgetBackgroundPrimary,
            )
          : null,
      floatingActionButton: floatingActionButton,
      backgroundColor: AppColors.defaultBackground,
      bottomNavigationBar: showNavBar ? const MainNavigationBar() : null,
      extendBody: true,
      body: body,
    );
  }
}
