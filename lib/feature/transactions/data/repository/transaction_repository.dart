import 'package:expense_tracker/feature/transactions/data/local/transaction_local_source_interface.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/create_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/update_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/output/transaction_stream_output.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';

class TransactionRepository implements TransactionRepositoryInterface {
  const TransactionRepository(this._localSource);

  final TransactionLocalSourceInterface _localSource;

  @override
  Stream<TransactionStreamOutput> get transactionsStream =>
      _localSource.transactionsStream;

  @override
  Future<Transaction> createTransaction(CreateTransactionInput input) {
    return _localSource.createTransaction(input);
  }

  @override
  Future<void> deleteTransaction(String id) {
    return _localSource.deleteTransaction(id);
  }

  @override
  Future<Transaction> getTransaction(String id) {
    return _localSource.getTransaction(id);
  }

  @override
  Future<List<Transaction>> getTransactions({TransactionMonth? month}) {
    return _localSource.getTransactions(month: month);
  }

  @override
  Future<Transaction> updateTransaction(UpdateTransactionInput input) {
    return _localSource.updateTransaction(input);
  }
}
