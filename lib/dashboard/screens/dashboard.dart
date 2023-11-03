import 'dart:math';

import 'package:expense_tracker/common/components/see_more_button.dart';
import 'package:expense_tracker/dashboard/components/budget_usage_card.dart';
import 'package:expense_tracker/dashboard/components/category_preview_card.dart';
import 'package:expense_tracker/dashboard/components/dashboard_section.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = [
      'Transport',
      'Clothing',
      'Food',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.8),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: const [
              const SizedBox(height: 30),
              BudgetUsageCard(),
              const SizedBox(height: 30),
              _CategoriesSection(categories: categories),
              DashboardSection(
                label: 'Transaction History',
                child: Text('hi'),
              ),
            ],
          ),
        ),
      ),
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
