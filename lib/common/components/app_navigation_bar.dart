import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/enums/navigation_item_type.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  static const _navigationItems = [
    NavigationItemType.dashboard,
    NavigationItemType.categories,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // const SizedBox.expand(),
        Padding(
          padding: const EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Container(
              height: Constants.navBarHeight,
              color: AppColors.dashboardBackground,
              child: Row(
                children: [
                  ..._navigationItems.map((item) {
                    final path = GoRouter.of(context)
                        .routerDelegate
                        .currentConfiguration
                        .fullPath;
                    final isSelected = item.routeName == path;

                    return Expanded(
                      child: IconButton(
                        onPressed: () => context.go(item.routeName),
                        icon: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Icon(
                                isSelected
                                    ? item.selectedIcon
                                    : item.defaultIcon,
                                color: Colors.white,
                                size: isSelected ? 24 : 30,
                              ),
                            ),
                            if (isSelected)
                              Text(
                                item.label,
                                style: TextStyles.body.copyWith(
                                  color: Colors.white,
                                ),
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
        ),
        // GestureDetector(
        //   onTap: () => print('hi'),
        //   child: Container(
        //     height: 50,
        //     width: 50,
        //     decoration: const BoxDecoration(
        //       color: Colors.deepPurpleAccent,
        //       shape: BoxShape.circle,
        //     ),
        //     child: const Icon(
        //       Icons.add_rounded,
        //       color: Colors.white,
        //       size: 40,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
