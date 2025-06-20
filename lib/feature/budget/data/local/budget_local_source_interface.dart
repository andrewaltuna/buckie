import 'package:expense_tracker/feature/budget/data/model/input/set_budget_input.dart';
import 'package:expense_tracker/feature/budget/data/model/output/budget.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';

abstract class BudgetLocalSourceInterface {
  Future<Budget?> getBudget(TransactionMonth month);

  Future<Budget?> getLatestBudget();

  Future<void> setBudget(SetBudgetInput input);

  Stream<Budget> get budgetStream;
}
