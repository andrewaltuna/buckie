import 'package:expense_tracker/categories/models/budget_category.dart';
import 'package:expense_tracker/common/helpers/formatter.dart';
import 'package:expense_tracker/dashboard/helpers/dashboard_drawer_helper.dart';
import 'package:expense_tracker/transactions/models/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(const CategoriesState()) {
    on<CategoriesLoaded>(_onLoaded);
  }

  void _onLoaded(
    CategoriesLoaded event,
    Emitter<CategoriesState> emit,
  ) {
    emit(
      state.copyWith(
        categories: DashboardDrawerHelper.generatePlaceholderCategories(10),
      ),
    );
  }
}
