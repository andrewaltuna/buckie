import 'package:expense_tracker/feature/budget/data/model/input/create_budget_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';

abstract interface class BudgetRemoteSourceInterface {
  Future<int> getLatestBudget();

  Future<int> getBudget(TransactionMonth month);

  Future<void> setBudget(CreateBudgetInput input);
}
