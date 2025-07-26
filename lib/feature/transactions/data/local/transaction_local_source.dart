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

  static const _transactionsTable = 'transactions';
  static const _categoriesTable = 'categories';

  final Database _db;

  final _streamController =
      StreamController<TransactionStreamOutput>.broadcast();

  @override
  Stream<TransactionStreamOutput> get transactionsStream =>
      _streamController.stream;

  @override
  Future<t.Transaction> getTransaction(String id) async {
    final result = await _db.rawQuery(
      _generateRawQuery(where: 't.id = ?'),
      [id],
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

      result = await _db.rawQuery(
        _generateRawQuery(
          where: 't.date >= ? AND t.date < ?',
          orderBy: 't.date DESC, t.created_at DESC',
        ),
        [startDate, endDate],
      );
    } else {
      result = await _db.rawQuery(
        _generateRawQuery(
          orderBy: 'date DESC, created_at DESC',
          limit: 10,
        ),
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

  String _generateRawQuery({
    String where = '',
    String orderBy = '',
    int? limit,
  }) {
    final whereStatement = where.isNotEmpty ? 'WHERE $where' : '';
    final orderByStatement = orderBy.isNotEmpty ? 'ORDER BY $orderBy' : '';
    final limitStatement = limit != null ? 'LIMIT $limit' : '';

    return '''
      SELECT 
        t.id AS t_id,
        t.amount AS t_amount,
        t.remarks AS t_remarks,
        t.date AS t_date,
        t.category_id AS c_id,
        c.label AS c_label,
        c.icon AS c_icon,
        c.color AS c_color
      FROM $_transactionsTable t
      LEFT JOIN $_categoriesTable c
        ON t.category_id = c.id
      $whereStatement
      $orderByStatement
      $limitStatement
    ''';
  }
}
