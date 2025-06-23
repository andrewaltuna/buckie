import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/categories/data/model/category.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/category_preview_card.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/dashboard_section.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/transaction_preview_card.dart';
import 'package:expense_tracker/feature/dashboard/presentation/helper/dashboard_drawer_helper.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/dashboard_drawer_view_model.dart';
import 'package:expense_tracker/feature/transactions/presentation/view_model/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({
    required this.constraints,
    required this.categories,
    required this.expense,
    super.key,
  });

  final BoxConstraints constraints;
  final List<Category> categories;
  final double expense;

  void _onDrawerDrag(
    BuildContext context,
    DragUpdateDetails details,
    BoxConstraints constraints,
  ) {
    final scale = context.read<DashboardDrawerViewModel>().state.scale;
    final currentHeight = scale * constraints.maxHeight;

    final size = (currentHeight + -details.delta.dy) / constraints.maxHeight;

    if (DashboardDrawerHelper.exceedsConstraints(size)) return;

    context.read<DashboardDrawerViewModel>().onDrag(size);
  }

  void _onDrawerDragEnd(BuildContext context) {
    context.read<DashboardDrawerViewModel>().onDragEnd();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardDrawerViewModel>().state;

    return AnimatedContainer(
      curve: Curves.easeIn,
      duration:
          state.isDragging ? Duration.zero : const Duration(milliseconds: 100),
      height: constraints.maxHeight * state.scale,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: AppColors.widgetBackgroundPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onVerticalDragUpdate: (details) => _onDrawerDrag(
              context,
              details,
              constraints,
            ),
            onVerticalDragEnd: (_) => _onDrawerDragEnd(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Container(
                height: 8,
                width: 50,
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.fontPrimary,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _CategoriesSection(
                  categories: categories,
                  expense: expense,
                ),
                const SizedBox(height: 16),
                const _RecentTransactionsSection(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection({
    required this.categories,
    required this.expense,
  });

  final List<Category> categories;
  final double expense;

  @override
  Widget build(BuildContext context) {
    final categories = this.categories.take(2).toList();

    return DashboardSection(
      label: 'Categories',
      showMoreButton: true,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: categories.length,
        itemBuilder: (_, index) => CategoryPreviewCard(
          category: categories[index],
          totalExpense: expense,
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
      ),
    );
  }
}

class _RecentTransactionsSection extends StatelessWidget {
  const _RecentTransactionsSection();

  @override
  Widget build(BuildContext context) {
    final recentTransactions = context.select(
      (TransactionsViewModel viewModel) => viewModel.state.recentTransactions,
    );

    return DashboardSection(
      label: 'Recent Transactions',
      showMoreButton: true,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: recentTransactions.length,
        itemBuilder: (_, index) => TransactionPreviewCard(
          transaction: recentTransactions[index],
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
      ),
    );
  }
}
