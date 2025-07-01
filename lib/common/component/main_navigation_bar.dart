import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/enum/navigation_item_type.dart';
import 'package:expense_tracker/common/extension/screen_size.dart';
import 'package:expense_tracker/common/helper/haptic_feedback_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/transactions/presentation/screen/create_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _kCircularPadding = 12.0;

// TODO: Uncomment as features are finished
const _kNavigationItems = [
  NavigationItemType.dashboard,
  // NavigationItemType.categories,
  NavigationItemType.create,
  NavigationItemType.transactions,
  // NavigationItemType.settings,
];

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final perItemWidth = (context.width - 30) / 5;

    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: Constants.navBarHeight + (_kCircularPadding * 2),
            width: (perItemWidth * _kNavigationItems.length) + 50,
            padding: const EdgeInsets.all(_kCircularPadding),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 8,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.widgetBackgroundSecondary,
                  ),
                  child: Row(
                    children: _kNavigationItems.map((item) {
                      if (item == NavigationItemType.create) {
                        return const Expanded(
                          child: _CreateButton(),
                        );
                      }

                      final path = GoRouter.of(context)
                          .routerDelegate
                          .currentConfiguration
                          .fullPath;

                      final isSelected = item.routePath == path;

                      return Expanded(
                        child: IconButton(
                          onPressed: () => context.goNamed(item.routeName),
                          icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isSelected
                                    ? item.selectedIcon
                                    : item.defaultIcon,
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton();

  void _onTap(BuildContext context) {
    HapticFeedbackHelper.heavy();

    context.pushNamed(CreateTransactionScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.accent,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () => _onTap(context),
        color: AppColors.fontButtonPrimary,
        icon: const Icon(
          Icons.add_rounded,
          size: 35,
        ),
      ),
    );
  }
}
