import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/di/service_locator.dart';
import 'package:expense_tracker/feature/categories/data/repository/category_repository_interface.dart';
import 'package:expense_tracker/feature/categories/presentation/component/create_category_form.dart';
import 'package:expense_tracker/feature/categories/presentation/screen/categories_screen.dart';
import 'package:expense_tracker/feature/categories/presentation/view_model/create_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  static const routeName = 'Create Category';
  static const routePath = '${CategoriesScreen.routePath}/create';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateCategoryViewModel(
        sl<CategoryRepositoryInterface>(),
      ),
      child: const MainScaffold(
        title: 'Create Category',
        showNavBar: false,
        showBackButton: true,
        body: CreateCategoryForm(),
      ),
    );
  }
}
