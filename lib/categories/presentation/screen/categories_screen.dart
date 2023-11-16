import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Categories',
      body: Container(),
    );
  }
}
