import 'package:expense_tracker/feature/budget/data/local/budget_local_source_interface.dart';
import 'package:expense_tracker/feature/budget/data/model/input/set_budget_input.dart';
import 'package:expense_tracker/feature/budget/data/model/output/budget.dart';
import 'package:expense_tracker/feature/budget/data/repository/budget_repository_interface.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';

class BudgetRepository implements BudgetRepositoryInterface {
  const BudgetRepository(this._localSource);

  final BudgetLocalSourceInterface _localSource;

  @override
  Stream<Budget> get budgetStream => _localSource.budgetStream;

  @override
  Future<Budget?> getLatestBudget() {
    return _localSource.getLatestBudget();
  }

  @override
  Future<Budget?> getBudget(TransactionMonth month) {
    return _localSource.getBudget(month);
  }

  @override
  Future<void> setBudget(SetBudgetInput input) {
    return _localSource.setBudget(input);
  }
}
