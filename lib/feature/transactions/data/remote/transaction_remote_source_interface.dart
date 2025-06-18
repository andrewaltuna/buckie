import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/create_transaction_input.dart';

abstract interface class TransactionRemoteSourceInterface {
  Stream<TransactionMonth> get transactionsStream;

  void initializeTransactionsStream();

  Future<List<Transaction>> getTransactions({TransactionMonth? month});

  Future<Transaction> getTransaction(String id);

  Future<Transaction> createTransaction(CreateTransactionInput input);

  Future<Transaction> updateTransaction(String id, Transaction transaction);

  Future<void> deleteTransaction(String id);
}
