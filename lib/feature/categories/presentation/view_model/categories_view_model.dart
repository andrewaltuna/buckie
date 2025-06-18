import 'package:expense_tracker/feature/categories/data/model/transaction_category.dart';
import 'package:expense_tracker/common/helper/formatter.dart';
import 'package:expense_tracker/feature/dashboard/presentation/helper/dashboard_drawer_helper.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesViewModel extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesViewModel() : super(const CategoriesState()) {
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
