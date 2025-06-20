import 'package:expense_tracker/feature/transactions/data/local/transaction_local_source_interface.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/create_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/update_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
import 'package:expense_tracker/feature/transactions/data/remote/transaction_remote_source_interface.dart';

const _kUseLocal = true;

class TransactionRepository implements TransactionRepositoryInterface {
  const TransactionRepository(this._remoteSource, this._localSource);

  final TransactionRemoteSourceInterface _remoteSource;
  final TransactionLocalSourceInterface _localSource;

  @override
  Stream<TransactionMonth?> get transactionsStream =>
      _localSource.transactionsStream;

  @override
  void initializeTransactionsStream() {
    _kUseLocal ? null : _remoteSource.initializeTransactionsStream();
  }

  @override
  Future<Transaction> createTransaction(CreateTransactionInput input) {
    return _kUseLocal
        ? _localSource.createTransaction(input)
        : _remoteSource.createTransaction(input);
  }

  @override
  Future<void> deleteTransaction(String id) {
    return _kUseLocal
        ? _localSource.deleteTransaction(id)
        : _remoteSource.deleteTransaction(id);
  }

  @override
  Future<Transaction> getTransaction(String id) {
    return _kUseLocal
        ? _localSource.getTransaction(id)
        : _remoteSource.getTransaction(id);
  }

  @override
  Future<List<Transaction>> getTransactions({TransactionMonth? month}) {
    return _kUseLocal
        ? _localSource.getTransactions(month: month)
        : _remoteSource.getTransactions(month: month);
  }

  @override
  Future<Transaction> updateTransaction(UpdateTransactionInput input) {
    return _kUseLocal
        ? _localSource.updateTransaction(input)
        : _remoteSource.updateTransaction(input);
  }
}
