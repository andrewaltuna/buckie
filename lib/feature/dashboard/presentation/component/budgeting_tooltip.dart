import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

class BudgetingTooltip extends StatelessWidget {
  const BudgetingTooltip({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperTooltip(
      content: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Budgeting',
              style: TextStyles.titleSmall.copyWith(
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Set your monthly budget by tapping the ',
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.settings,
                      color: AppColors.fontPrimary,
                      size: 18,
                    ),
                  ),
                  TextSpan(
                    text: ' icon in order to see your remaining balance.',
                  ),
                ],
                style: TextStyles.bodyMedium,
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Optionally, once a budget is set, the pie-chart below can be toggled to include your remaining balance for the month using the ',
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.visibility,
                      color: AppColors.fontPrimary,
                      size: 18,
                    ),
                  ),
                  TextSpan(text: ' icon.'),
                ],
                style: TextStyles.bodyMedium,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.defaultBackground,
      child: const Icon(
        Icons.info_outlined,
        color: AppColors.accent,
        size: 24,
      ),
    );
  }
}
