import 'dart:async';

import 'package:expense_tracker/feature/transactions/data/model/entity/transaction.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/create_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/model/input/update_transaction_input.dart';
import 'package:expense_tracker/feature/transactions/data/remote/transaction_remote_source_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionRemoteSource implements TransactionRemoteSourceInterface {
  TransactionRemoteSource(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  static const _schema = 'public';
  static const _table = 'transactions';

  final _controller = StreamController<TransactionMonth?>.broadcast();

  @override
  void initializeTransactionsStream() {
    final channel = _supabaseClient.channel('$_schema:$_table');

    channel
      ..onPostgresChanges(
        event: PostgresChangeEvent.all,
        table: _table,
        schema: _schema,
        callback: (payload) {
          final isDelete = payload.newRecord.isEmpty;

          if (isDelete) return _controller.add(null);

          final transaction = Transaction.fromJson(payload.newRecord);

          _controller.add(transaction.month);
        },
      )
      ..subscribe();

    _controller.onCancel = () => _supabaseClient.removeChannel(channel);

    // Keep in case of revert. Streams individual transaction data.
    /*
    channel
      ..onPostgresChanges(
        event: PostgresChangeEvent.insert,
        table: _table,
        schema: _schema,
        callback: (payload) {
          final inserted = Transaction.fromJson(payload.newRecord);

          _controller.add(TransactionStreamOutput.insert(inserted));
        },
      )
      ..onPostgresChanges(
        event: PostgresChangeEvent.update,
        table: _table,
        schema: _schema,
        callback: (payload) {
          final updated = Transaction.fromJson(payload.newRecord);

          _controller.add(TransactionStreamOutput.insert(updated));
        },
      )
      ..onPostgresChanges(
        event: PostgresChangeEvent.delete,
        table: _table,
        schema: _schema,
        callback: (payload) {
          final id = payload.oldRecord['id'];

          _controller.add(TransactionStreamOutput.delete(id));
        },
      );
    */
  }

  @override
  Stream<TransactionMonth?> get transactionsStream => _controller.stream;

  @override
  Future<Transaction> getTransaction(String id) {
    // TODO: implement getTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getTransactions({
    TransactionMonth? month,
  }) async {
    final List<Map<String, dynamic>> result;

    if (month != null) {
      final start = month.toDateTime();
      final end = start.copyWith(
        month: start.month + 1,
      );

      result = await _supabaseClient
          .from(_table)
          .select(_transactionFullOutput)
          .gte('date', start)
          .lt('date', end)
          .order('date', ascending: false)
          .order('created_at', ascending: false);
    } else {
      result = await _supabaseClient
          .from(_table)
          .select(_transactionFullOutput)
          .order('date', ascending: false)
          .order('created_at', ascending: false)
          .limit(10);
    }

    return result.map(Transaction.fromJson).toList();
  }

  @override
  Future<Transaction> createTransaction(
    CreateTransactionInput transaction,
  ) async {
    final result = await _supabaseClient
        .from(_table)
        .insert(
          transaction.toJson(),
        )
        .select(_transactionFullOutput);

    return Transaction.fromJson(result.first);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await _supabaseClient.from(_table).delete().eq('id', id);
  }

  @override
  Future<Transaction> updateTransaction(
    UpdateTransactionInput input,
  ) async {
    final result = await _supabaseClient
        .from(_table)
        .update(input.toJson())
        .eq('id', input.id)
        .select(_transactionFullOutput);

    return Transaction.fromJson(result.first);
  }
}

const _transactionFullOutput = '''
    id, 
    date, 
    category, 
    remarks, 
    amount
  ''';
