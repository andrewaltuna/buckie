import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    this.color = AppColors.fontPrimary,
    super.key,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Pressed'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'See more',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: color,
          ),
        ],
      ),
    );
  }
}
