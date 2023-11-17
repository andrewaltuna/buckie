import 'package:expense_tracker/common/component/main_navigation_bar.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.body,
    this.title,
    this.widget,
    this.showAppBar = true,
    this.showBackButton = false,
    this.showNavBar = true,
    this.floatingActionButton,
  });

  final String? title;
  final Widget? widget;
  final Widget body;
  final bool showAppBar;
  final bool showBackButton;
  final bool showNavBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    final widget = this.widget;

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              leadingWidth: 0,
              title: Stack(
                alignment: Alignment.center,
                children: [
                  if (showBackButton)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  if (widget != null) widget,
                  if (title != null)
                    Text(
                      title,
                      style: TextStyles.title.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                ],
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
