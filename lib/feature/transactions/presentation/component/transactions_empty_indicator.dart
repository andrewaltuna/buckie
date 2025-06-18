import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class TransactionsEmptyIndicator extends StatelessWidget {
  const TransactionsEmptyIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'No records yet',
          style: TextStyles.titleSmall,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Tap  ',
              style: TextStyles.bodyRegular,
            ),
            Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_rounded,
                size: 14,
              ),
            ),
            const Text(
              '  to log a transaction',
              style: TextStyles.bodyRegular,
            ),
          ],
        ),
      ],
    );
  }
}
