import 'dart:async';

import 'package:expense_tracker/feature/transactions/data/local/transaction_local_source.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart'
    as t;
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/create_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/update_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/transaction_typedefs.dart';
import 'package:sqflite/sqflite.dart';

class TransactionLocalSourceImpl implements TransactionLocalSource {
  TransactionLocalSourceImpl(this._db);

  static const _transactionsTable = 'transactions';

  final Database _db;

  final _streamController =
      StreamController<TransactionStreamOutput>.broadcast();

  @override
  Stream<TransactionStreamOutput> get transactionsStream =>
      _streamController.stream;

  @override
  Future<t.Transaction> getTransaction(int id) async {
    final result = await _db.query(
      _transactionsTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) throw Exception('Transaction not found');

    return t.Transaction.fromJson(result.first);
  }

  @override
  Future<List<t.Transaction>> getTransactions({TransactionMonth? month}) async {
    final List<Map<String, dynamic>> result;

    if (month != null) {
      final startDate = month.toIso8601String();
      final endDate = month.copyWith(month: month.month + 1).toIso8601String();

      result = await _db.query(
        _transactionsTable,
        where: 'date >= ? AND date < ?',
        whereArgs: [startDate, endDate],
        orderBy: 'date DESC, created_at DESC',
      );
    } else {
      result = await _db.query(
        _transactionsTable,
        orderBy: 'date DESC, created_at DESC',
        limit: 10,
      );
    }

    return List.generate(
      result.length,
      (i) => t.Transaction.fromJson(result[i]),
    );
  }

  @override
  Future<t.Transaction> createTransaction(CreateTransactionInput input) async {
    final id = await _db.insert(
      _transactionsTable,
      input.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final transaction = await getTransaction(id);

    _streamController.add(
      TransactionStreamOutput.insert(transaction),
    );

    return transaction;
  }

  @override
  Future<void> deleteTransaction(int id) async {
    final transaction = await getTransaction(id);

    await _db.delete(
      _transactionsTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    _streamController.add(
      TransactionStreamOutput.delete(transaction),
    );
  }

  @override
  Future<t.Transaction> updateTransaction(UpdateTransactionInput input) async {
    final oldTransaction = await getTransaction(input.id);

    await _db.update(
      _transactionsTable,
      input.toJson(),
      where: 'id = ?',
      whereArgs: [input.id],
    );

    final newTransaction = await getTransaction(input.id);

    _streamController.add(
      TransactionStreamOutput.update(
        oldTransaction,
        newTransaction,
      ),
    );

    return newTransaction;
  }
}
