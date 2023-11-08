import 'package:expense_tracker/common/components/app_scaffold.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Categories',
      body: Container(
        child: Text('hi'),
      ),
    );
  }
}
