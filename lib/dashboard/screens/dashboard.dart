import 'dart:math';

import 'package:expense_tracker/common/components/see_more_button.dart';
import 'package:expense_tracker/dashboard/components/budget_usage_card.dart';
import 'package:expense_tracker/dashboard/components/category_preview_card.dart';
import 'package:expense_tracker/dashboard/components/dashboard_section.dart';
import 'package:expense_tracker/dashboard/helpers/dashboard_drawer_helper.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = [
      'Transport',
      'Clothing',
      'Food',
      'Transport',
      'Clothing',
      'Food',
      'Transport',
      'Clothing',
      'Food',
      'Transport',
      'Clothing',
      'Food',
    ];
    final controller = DraggableScrollableController();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Expense Tracker',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.8),
      ),
      body: Stack(
        children: [
          // Background color
          Container(
            color: const Color(0xFF1EFFBC),
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

  final List<String> categories;
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            BudgetUsageCard(
              height: constraints.maxHeight *
                  (1 - DashboardDrawerHelper.percentageMinHeight),
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
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Workaround for scrolling
                      ListView(
                        shrinkWrap: true,
                        controller: scrollController,
                        padding: EdgeInsets.zero,
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

  final List<String> categories;

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
              return CategoryPreviewCard(label: categories[index]);
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
          const SizedBox(height: 10),
          const SeeMoreButton(),
        ],
      ),
    );
  }
}
