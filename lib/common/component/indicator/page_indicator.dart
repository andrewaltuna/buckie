import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    required this.pageCount,
    this.selectedPageIndex = 0,
    super.key,
  });

  final int pageCount;
  final int selectedPageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 8,
          width: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index == selectedPageIndex
                ? AppColors.accent
                : AppColors.widgetBackgroundSecondary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
