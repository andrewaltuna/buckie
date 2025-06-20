import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/create_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/update_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/output/transaction_stream_output.dart';

abstract interface class TransactionLocalSourceInterface {
  Stream<TransactionStreamOutput> get transactionsStream;

  Future<List<Transaction>> getTransactions({TransactionMonth? month});

  Future<Transaction> getTransaction(String id);

  Future<Transaction> createTransaction(CreateTransactionInput input);

  Future<Transaction> updateTransaction(UpdateTransactionInput input);

  Future<void> deleteTransaction(String id);
}
