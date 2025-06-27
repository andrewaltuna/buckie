import 'package:expense_tracker/common/component/main_navigation_bar.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    required this.body,
    this.title,
    this.titleWidget,
    this.showAppBar = true,
    this.showBackButton = false,
    this.showNavBar = true,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    super.key,
  });

  final String? title;
  final Widget? titleWidget;
  final Widget body;
  final bool showAppBar;
  final bool showBackButton;
  final bool showNavBar;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              elevation: 0,
              leadingWidth: 0,
              surfaceTintColor: Colors.transparent,
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
                  if (title != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title!,
                          style: TextStyles.titleMedium.copyWith(
                            color: AppColors.accent,
                          ),
                        ),
                        if (titleWidget != null) ...[
                          const SizedBox(width: 8),
                          titleWidget!,
                        ],
                      ],
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
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        bottom: !showNavBar,
        child: Center(
          child: body,
        ),
      ),
    );
  }
}
