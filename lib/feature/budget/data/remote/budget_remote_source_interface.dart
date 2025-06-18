import 'package:expense_tracker/feature/budget/data/model/input/set_budget_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';

abstract interface class BudgetRemoteSourceInterface {
  Future<double?> getLatestBudget();

  Future<double?> getBudget(TransactionMonth month);

  Future<void> setBudget(SetBudgetInput input);
}
