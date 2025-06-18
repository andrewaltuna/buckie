import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/create_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/update_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
import 'package:expense_tracker/feature/transactions/data/remote/transaction_remote_source_interface.dart';

class TransactionRepository implements TransactionRepositoryInterface {
  const TransactionRepository(this._remoteSource);

  final TransactionRemoteSourceInterface _remoteSource;

  @override
  Stream<TransactionMonth> get transactionsStream =>
      _remoteSource.transactionsStream;

  @override
  void initializeTransactionsStream() {
    _remoteSource.initializeTransactionsStream();
  }

  @override
  Future<Transaction> createTransaction(CreateTransactionInput input) {
    return _remoteSource.createTransaction(input);
  }

  @override
  Future<void> deleteTransaction(String id) {
    return _remoteSource.deleteTransaction(id);
  }

  @override
  Future<Transaction> getTransaction(String id) {
    return _remoteSource.getTransaction(id);
  }

  @override
  Future<List<Transaction>> getTransactions({TransactionMonth? month}) {
    return _remoteSource.getTransactions(month: month);
  }

  @override
  Future<Transaction> updateTransaction(UpdateTransactionInput input) {
    return _remoteSource.updateTransaction(input);
  }
}
