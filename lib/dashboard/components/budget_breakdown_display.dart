import 'package:expense_tracker/categories/models/budget_category.dart';
import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/dashboard/blocs/budget_breakdown_cubit.dart';
import 'package:expense_tracker/dashboard/components/budget_breakdown_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetBreakdownDisplay extends StatelessWidget {
  const BudgetBreakdownDisplay({
    super.key,
    required this.totalBudget,
    required this.categories,
    this.height = 200,
  });

  final double totalBudget;
  final List<BudgetCategory> categories;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black.withOpacity(0.5),
              ),
              child: const IntrinsicHeight(
                child: Row(
                  children: [
                    _ValueLabel(label: 'Spent', value: '${r'$'}3,000'),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: VerticalDivider(
                        thickness: 2,
                        width: 0,
                        color: Colors.white,
                      ),
                    ),
                    _ValueLabel(label: 'Total', value: '${r'$'}5,000'),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: BudgetBreakdownChart(
                centerSpaceRadius: 50,
                categories: categories,
                totalBudget: totalBudget,
              ),
            ),
          ),
          const _ToggleRemainingButton(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class _ToggleRemainingButton extends StatelessWidget {
  const _ToggleRemainingButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBreakdownCubit, BudgetBreakdownState>(
      builder: (context, state) {
        final labelPrefix = state.showRemaining ? 'Hide' : 'Show';

        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () =>
              context.read<BudgetBreakdownCubit>().toggleShowRemaining(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  state.showRemaining ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.dashboardBackground,
                ),
                const SizedBox(width: 10),
                Text(
                  'Remaining',
                  style: TextStyles.body.copyWith(
                    color: AppColors.dashboardBackground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ValueLabel extends StatelessWidget {
  const _ValueLabel({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.fontFamilySecondary,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
