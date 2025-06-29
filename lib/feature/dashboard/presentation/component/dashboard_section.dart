import 'package:expense_tracker/common/component/button/see_more_button.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:flutter/material.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({
    required this.label,
    required this.child,
    this.showMoreButton = false,
    this.onShowMore,
    this.expanded = false,
    super.key,
  });

  final String label;
  final bool showMoreButton;
  final bool expanded;
  final void Function(bool)? onShowMore;
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
                style: AppTextStyles.titleRegular.copyWith(
                  color: AppColors.fontPrimary,
                ),
              ),
            ),
            if (showMoreButton)
              SeeMoreButton(
                expanded: expanded,
                color: AppColors.accent,
                onTap: onShowMore,
              ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
