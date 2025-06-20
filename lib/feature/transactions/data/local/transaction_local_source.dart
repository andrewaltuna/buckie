import 'dart:async';

import 'package:expense_tracker/feature/transactions/data/local/transaction_local_source_interface.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart'
    as t;
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/create_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/update_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/output/transaction_stream_output.dart';
import 'package:sqflite/sqflite.dart';

class TransactionLocalSource implements TransactionLocalSourceInterface {
  TransactionLocalSource(this._db);

  static const _table = 'transactions';

  final Database _db;

  final _streamController =
      StreamController<TransactionStreamOutput>.broadcast();

  @override
  Stream<TransactionStreamOutput> get transactionsStream =>
      _streamController.stream;

  @override
  Future<t.Transaction> getTransaction(String id) async {
    final result = await _db.query(
      _table,
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
        _table,
        where: 'date >= ? AND date < ?',
        whereArgs: [startDate, endDate],
        orderBy: 'date DESC',
      );
    } else {
      result = await _db.query(
        _table,
        orderBy: 'date DESC',
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
      _table,
      input.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final transaction = await getTransaction(id.toString());

    _streamController.add(
      TransactionStreamOutput.insert(transaction),
    );

    return transaction;
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final transaction = await getTransaction(id);

    await _db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    _streamController.add(
      TransactionStreamOutput.delete(transaction),
    );
  }

  @override
  Future<t.Transaction> updateTransaction(UpdateTransactionInput input) async {
    await _db.update(
      _table,
      input.toJson(),
      where: 'id = ?',
      whereArgs: [input.id],
    );

    final transaction = await getTransaction(input.id);

    _streamController.add(
      TransactionStreamOutput.update(transaction),
    );

    return transaction;
  }
}
