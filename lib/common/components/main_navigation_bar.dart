import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/enums/navigation_item_type.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  static const _navigationItems = [
    NavigationItemType.dashboard,
    NavigationItemType.categories,
    NavigationItemType.create,
    NavigationItemType.transactions,
    NavigationItemType.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: Constants.navBarHeight,
          color: AppColors.widgetBackgroundSecondary,
          child: Row(
            children: [
              ..._navigationItems.map((item) {
                if (item == NavigationItemType.create) {
                  return const Expanded(
                    child: _CreateButton(),
                  );
                }

                final path = GoRouter.of(context)
                    .routerDelegate
                    .currentConfiguration
                    .fullPath;
                final isSelected = item.routeName == path;

                return Expanded(
                  child: IconButton(
                    onPressed: () => context.go(item.routeName),
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isSelected ? item.selectedIcon : item.defaultIcon,
                          color: isSelected
                              ? AppColors.accent
                              : AppColors.fontPrimary,
                          size: isSelected ? 34 : 30,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: const ShapeDecoration(
              shape: CircleBorder(),
              color: AppColors.accent,
            ),
            child: IconButton(
              onPressed: () => print('hello'),
              color: AppColors.defaultBackground,
              icon: const Icon(
                Icons.add_rounded,
                size: 35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
