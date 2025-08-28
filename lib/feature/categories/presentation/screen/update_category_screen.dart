import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/di/service_locator.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/data/repository/category_repository_interface.dart';
import 'package:expense_tracker/feature/categories/presentation/component/create_category_form.dart';
import 'package:expense_tracker/feature/categories/presentation/screen/categories_screen.dart';
import 'package:expense_tracker/feature/categories/presentation/view_model/create_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateCategoryScreen extends StatelessWidget {
  const UpdateCategoryScreen({
    required this.category,
    super.key,
  });

  static const routeName = 'Update Category';
  static const routePath = '${CategoriesScreen.routePath}/update/:id';

  static void navigateTo({
    required BuildContext context,
    required CategoryDetails category,
  }) {
    context.pushNamed(
      routeName,
      pathParameters: {
        'id': category.id.toString(),
      },
      extra: category,
    );
  }

  final CategoryDetails category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateCategoryViewModel(
        sl<CategoryRepositoryInterface>(),
        categoryId: category.id,
      )
        ..add(CreateCategoryNameUpdated(category.name))
        ..add(CreateCategoryColorUpdated(category.color))
        ..add(CreateCategoryIconUpdated(category.icon)),
      child: MainScaffold(
        title: 'Update Category',
        showNavBar: false,
        showBackButton: true,
        body: CreateCategoryForm(
          category: category,
        ),
      ),
    );
  }
}
