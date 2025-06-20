import 'dart:async';

import 'package:expense_tracker/feature/transactions/data/local/transaction_local_source_interface.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart'
    as t;
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/create_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/update_transaction_input.dart';
import 'package:sqflite/sqflite.dart';

class TransactionLocalSource implements TransactionLocalSourceInterface {
  TransactionLocalSource(this._db);

  static const _table = 'transactions';

  final Database _db;

  final _streamController = StreamController<TransactionMonth?>.broadcast();

  @override
  Stream<TransactionMonth?> get transactionsStream => _streamController.stream;

  @override
  Future<t.Transaction> createTransaction(CreateTransactionInput input) async {
    final id = await _db.insert(
      _table,
      input.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final month = TransactionMonth.fromDate(input.date);

    _streamController.add(month);

    return await getTransaction(id.toString());
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final transaction = await getTransaction(id);

    await _db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    _streamController.add(transaction.month);
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
  Future<t.Transaction> updateTransaction(UpdateTransactionInput input) async {
    await _db.update(
      _table,
      input.toJson(),
      where: 'id = ?',
      whereArgs: [input.id],
    );

    final month = TransactionMonth.fromDate(input.date);

    _streamController.add(month);

    return await getTransaction(input.id);
  }

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
}
