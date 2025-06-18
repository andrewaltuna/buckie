import 'package:expense_tracker/feature/budget/data/model/input/create_budget_input.dart';
import 'package:expense_tracker/feature/budget/data/remote/budget_remote_source_interface.dart';
import 'package:expense_tracker/feature/budget/data/repository/budget_repository_interface.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';

class BudgetRepository implements BudgetRepositoryInterface {
  const BudgetRepository(this._remoteSource);

  final BudgetRemoteSourceInterface _remoteSource;

  @override
  Future<int> getLatestBudget() {
    return _remoteSource.getLatestBudget();
  }

  @override
  Future<int> getBudget(TransactionMonth month) {
    return _remoteSource.getBudget(month);
  }

  @override
  Future<void> setBudget(CreateBudgetInput input) {
    return _remoteSource.setBudget(input);
  }
}
