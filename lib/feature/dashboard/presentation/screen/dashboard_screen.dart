import 'dart:math';

import 'package:expense_tracker/feature/categories/data/model/budget_category.dart';
import 'package:expense_tracker/feature/categories/presentation/view_model/categories_view_model.dart';
import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/component/button/see_more_button.dart';
import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/budget_breakdown_display.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/category_preview_card.dart';
import 'package:expense_tracker/feature/dashboard/presentation/component/dashboard_section.dart';
import 'package:expense_tracker/feature/dashboard/presentation/helper/dashboard_drawer_helper.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/budget_breakdown_view_model.dart';
import 'package:expense_tracker/feature/dashboard/presentation/view_model/dashboard_drawer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Overview',
      body: BlocProvider(
        create: (_) => DashboardDrawerViewModel(),
        child: const _Content(),
      ),
    );
  }
}

class _Content extends HookWidget {
  const _Content();

  void _onDrawerDrag(
    BuildContext context,
    DragUpdateDetails details,
    BoxConstraints constraints,
  ) {
    final vm = context.read<DashboardDrawerViewModel>();
    final currentHeight = vm.state.scale * constraints.maxHeight;

    final size = (currentHeight + -details.delta.dy) / constraints.maxHeight;

    if (DashboardDrawerHelper.exceedsConstraints(size)) return;

    context.read<DashboardDrawerViewModel>().onDrag(size);
  }

  void _onDrawerDragEnd(BuildContext context) {
    context.read<DashboardDrawerViewModel>().onDragEnd();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = context.watch<CategoriesViewModel>().state;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final budgetDisplayHeight =
            maxHeight * (1 - DashboardDrawerHelper.percentageMinHeight);

        return SizedBox.expand(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              BlocProvider(
                create: (_) => BudgetBreakdownViewModel(),
                child: BudgetBreakdownDisplay(
                  height: budgetDisplayHeight,
                  totalBudget: categoriesState.allBudgetTotal,
                  categories: categoriesState.categories,
                ),
              ),
              const Positioned.fill(
                child: _Overlay(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:
                    BlocBuilder<DashboardDrawerViewModel, DashboardDrawerState>(
                  builder: (context, state) {
                    return AnimatedContainer(
                      curve: Curves.easeIn,
                      duration: state.isDragging
                          ? Duration.zero
                          : const Duration(milliseconds: 100),
                      height: maxHeight * state.scale,
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
                                _onDrawerDrag(context, details, constraints),
                            onVerticalDragEnd: (_) => _onDrawerDragEnd(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: const BoxDecoration(),
                              child: Center(
                                child: Container(
                                  height: 8,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.fontPrimary,
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
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Overlay extends StatelessWidget {
  const _Overlay();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardDrawerViewModel, DashboardDrawerState>(
      builder: (_, state) {
        return IgnorePointer(
          child: Container(
            color: Colors.black.withOpacity(state.overlayOpacity),
          ),
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
