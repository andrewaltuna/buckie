import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/component/skeleton/skeleton_display.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardMonthSelector extends StatelessWidget {
  const DashboardMonthSelector({super.key});

  void _onTap(
    BuildContext context,
    bool forward,
  ) {
    context.read<DashboardViewModel>().adjustMonth(forward);
  }

  void _onSelectToday(BuildContext context) {
    final currentMonth = TransactionMonth.fromDate(DateTime.now());

    context.read<DashboardViewModel>().selectMonth(currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardViewModel, TransactionMonth?>(
      builder: (context, month) {
        final hasMonth = month != null;

        return AbsorbPointer(
          absorbing: !hasMonth,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.widgetBackgroundSecondary,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              children: [
                _ChevronButton(
                  forward: false,
                  onTap: (forward) => _onTap(context, forward),
                ),
                const Spacer(),
                SizedBox(
                  width: 100,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    transitionBuilder: (child, animation) {
                      return Opacity(
                        opacity: 1 - animation.value,
                        child: ScaleTransition(
                          scale: Tween(
                            begin: 0.95,
                            end: 1.0,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: hasMonth
                        ? Text(
                            key: ValueKey(month.toString()),
                            Formatter.date(
                              month.toDateTime(),
                              includeDay: false,
                            ),
                            style: AppTextStyles.titleRegular,
                          )
                        : const SkeletonDisplay(
                            height: 18,
                            width: 48,
                          ),
                  ),
                ),
                CustomInkWell(
                  onTap: () => _onSelectToday(context),
                  padding: const EdgeInsets.all(4),
                  borderRadius: 50,
                  child: const Icon(
                    Icons.calendar_month,
                    color: AppColors.accent,
                  ),
                ),
                const Spacer(),
                _ChevronButton(
                  forward: true,
                  onTap: (forward) => _onTap(context, forward),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ChevronButton extends StatelessWidget {
  const _ChevronButton({
    required this.forward,
    required this.onTap,
  });

  final bool forward;
  final void Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () => onTap(forward),
      color: AppColors.accent,
      borderRadius: 8,
      child: Icon(
        forward ? Icons.chevron_right : Icons.chevron_left,
        color: AppColors.fontButtonPrimary,
        size: 32,
      ),
    );
  }
}
