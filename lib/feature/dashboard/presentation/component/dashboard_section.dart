import 'package:expense_tracker/common/component/button/see_more_button.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({
    super.key,
    required this.label,
    required this.child,
    this.showMoreButton = false,
  });

  final String label;
  final bool showMoreButton;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyles.titleRegular.copyWith(
                  color: AppColors.fontPrimary,
                ),
              ),
            ),
            if (showMoreButton) const SeeMoreButton(color: AppColors.accent),
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
