import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    this.color = AppColors.fontPrimary,
    this.expanded = false,
    this.onTap,
    super.key,
  });

  final Color color;
  final bool expanded;
  final void Function(bool)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(!expanded),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            expanded ? 'Show less' : 'Show more',
            style: TextStyles.titleExtraSmall.copyWith(
              color: color,
            ),
          ),
          AnimatedRotation(
            duration: const Duration(milliseconds: 100),
            turns: expanded ? 0.75 : 1.25,
            child: Icon(
              Icons.chevron_right,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
