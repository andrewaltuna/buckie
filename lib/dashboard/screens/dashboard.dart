import 'dart:math';

import 'package:expense_tracker/categories/models/budget_category.dart';
import 'package:expense_tracker/common/components/app_scaffold.dart';
import 'package:expense_tracker/common/components/see_more_button.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/dashboard/blocs/budget_breakdown_cubit.dart';
import 'package:expense_tracker/dashboard/components/budget_breakdown_display.dart';
import 'package:expense_tracker/dashboard/components/category_preview_card.dart';
import 'package:expense_tracker/dashboard/components/dashboard_section.dart';
import 'package:expense_tracker/dashboard/helpers/dashboard_drawer_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = DashboardDrawerHelper.generatePlaceholderCategories(5);
    final controller = DraggableScrollableController();

    return AppScaffold(
      title: 'Overview',
      floatingActionButton: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.add, size: 50),
      ),
      body: Stack(
        children: [
          // Background color
          Container(
            color: AppColors.dashboardBackground,
          ),
          Positioned.fill(
            child: _Content(
              categories: categories,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.categories,
    required this.controller,
  });

  final List<BudgetCategory> categories;
  final DraggableScrollableController controller;

  void _onDrawerDrag(
    DragUpdateDetails details,
    BoxConstraints constraints,
  ) {
    final size =
        (controller.pixels + -details.delta.dy) / constraints.maxHeight;

    if (DashboardDrawerHelper.isBetween(size)) return;

    controller.jumpTo(size);
  }

  void _onDrawerDragEnd() {
    controller.animateTo(
      controller.size > DashboardDrawerHelper.percentageHeightMidpoint
          ? DashboardDrawerHelper.percentageMaxHeight
          : DashboardDrawerHelper.percentageMinHeight,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  double _getTotalBudget(List<BudgetCategory> categories) {
    double totalBudget = 0;
    for (var category in categories) {
      totalBudget += category.allottedBudget;
    }
    return totalBudget;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            BlocProvider(
              create: (_) => BudgetBreakdownCubit(),
              child: BudgetBreakdownDisplay(
                totalBudget: _getTotalBudget(categories),
                categories: categories,
                height: constraints.maxHeight *
                    (1 - DashboardDrawerHelper.percentageMinHeight),
              ),
            ),
            DraggableScrollableSheet(
              controller: controller,
              initialChildSize: DashboardDrawerHelper.percentageMinHeight,
              minChildSize: DashboardDrawerHelper.percentageMinHeight - 0.2,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    // vertical: 15,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onVerticalDragUpdate: (details) =>
                            _onDrawerDrag(details, constraints),
                        onVerticalDragEnd: (_) => _onDrawerDragEnd(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: const BoxDecoration(),
                          child: Center(
                            child: Container(
                              height: 8,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            _CategoriesSection(categories: categories),
                            const DashboardSection(
                              label: 'Transaction History',
                              child: Text('hi'),
                            ),
                          ],
                        ),
                      ),

                      // Workaround for scrolling
                      ListView(
                        shrinkWrap: true,
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection({
    required this.categories,
  });

  final List<BudgetCategory> categories;

  @override
  Widget build(BuildContext context) {
    return DashboardSection(
      label: 'Categories',
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              return CategoryPreviewCard(category: categories[index]);
            }),
            separatorBuilder: ((context, index) {
              // replace with childcount
              if (index == categories.length - 1) {
                return const SizedBox.shrink();
              }

              return const SizedBox(height: 10);
            }),
            itemCount: min(categories.length, 2),
          ),
          const SizedBox(height: 12),
          const SeeMoreButton(),
        ],
      ),
    );
  }
}
