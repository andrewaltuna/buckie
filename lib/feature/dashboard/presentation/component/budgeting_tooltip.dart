import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

class BudgetingTooltip extends StatelessWidget {
  const BudgetingTooltip({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperTooltip(
      backgroundColor: AppColors.defaultBackground,
      content: const Padding(
        padding: EdgeInsets.all(12),
        child: _Tooltip(),
      ),
      child: const Icon(
        Icons.info_outlined,
        color: AppColors.accent,
        size: 20,
      ),
    );
  }
}

class _Tooltip extends StatelessWidget {
  const _Tooltip();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Budgeting',
          style: AppTextStyles.titleSmall.copyWith(
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
                  Icons.edit_document,
                  color: AppColors.fontPrimary,
                  size: 18,
                ),
              ),
              TextSpan(
                text: ' icon in order to see your remaining balance.',
              ),
            ],
            style: AppTextStyles.bodyMedium,
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
            style: AppTextStyles.bodyMedium,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Symbols',
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.accent,
          ),
        ),
        const _SymbolItem(
          symbol: 'EXP',
          description: 'Total expenses',
        ),
        const _SymbolItem(
          symbol: 'BAL',
          description: 'Remaining balance',
        ),
        const _SymbolItem(
          symbol: 'BUD',
          description: 'Budget allocation',
        ),
      ],
    );
  }
}

class _SymbolItem extends StatelessWidget {
  const _SymbolItem({
    required this.symbol,
    required this.description,
  });

  final String symbol;
  final String description;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: symbol,
            style: AppTextStyles.titleExtraSmall,
          ),
          TextSpan(text: ' — $description'),
        ],
        style: AppTextStyles.bodyMedium,
      ),
    );
  }
}
