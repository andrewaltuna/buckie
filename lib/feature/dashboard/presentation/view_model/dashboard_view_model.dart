import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Returns selected month
class DashboardViewModel extends Cubit<TransactionMonth?> {
  DashboardViewModel() : super(null);

  void selectMonth(value) => emit(value);

  void adjustMonth(bool forward) {
    if (state == null) return;

    emit(
      state?.copyWith(
        month: state!.month + (forward ? 1 : -1),
      ),
    );
  }
}
