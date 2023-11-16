import 'dart:math';

import 'package:expense_tracker/categories/data/model/budget_category.dart';
import 'package:expense_tracker/categories/presentation/view_model/categories_view_model.dart';
import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/component/see_more_button.dart';
import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/dashboard/presentation/component/budget_breakdown_display.dart';
import 'package:expense_tracker/dashboard/presentation/component/category_preview_card.dart';
import 'package:expense_tracker/dashboard/presentation/component/dashboard_section.dart';
import 'package:expense_tracker/dashboard/presentation/helper/dashboard_drawer_helper.dart';
import 'package:expense_tracker/dashboard/presentation/view_model/budget_breakdown_view_model.dart';
import 'package:expense_tracker/dashboard/presentation/view_model/dashboard_drawer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    final controller = DraggableScrollableController();

    return MainScaffold(
      title: 'Overview',
      body: BlocProvider(
        create: (_) => DashboardDrawerViewModel(),
        child: _Content(
          controller: controller,
        ),
      ),
    );
  }
}

class _Content extends HookWidget {
  const _Content({
    required this.controller,
  });

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
    final categoriesState = context.watch<CategoriesViewModel>().state;

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.addListener(
            () {
              context
                  .read<DashboardDrawerViewModel>()
                  .updateOverlayOpacity(controller.size);
            },
          );
        });

        return;
      },
      [],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            BlocProvider(
              create: (_) => BudgetBreakdownViewModel(),
              child: BudgetBreakdownDisplay(
                totalBudget: categoriesState.allBudgetTotal,
                categories: categoriesState.categories,
                height: constraints.maxHeight *
                    (1 - DashboardDrawerHelper.percentageMinHeight),
              ),
            ),
            Positioned.fill(
              child:
                  BlocBuilder<DashboardDrawerViewModel, DashboardDrawerState>(
                builder: (context, state) {
                  return IgnorePointer(
                    child: Container(
                      color: Colors.black.withOpacity(state.overlayOpacity),
                    ),
                  );
                },
              ),
            ),
            DraggableScrollableSheet(
              controller: controller,
              initialChildSize: DashboardDrawerHelper.percentageMinHeight,
              minChildSize: DashboardDrawerHelper.percentageMinHeight - 0.2,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            _CategoriesSection(
                              categories: categoriesState.categories,
                            ),
                            const DashboardSection(
                              label: 'Recent Transactions',
                              child: Text(''),
                            ),
                            const SizedBox(height: Constants.navBarHeight),
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
