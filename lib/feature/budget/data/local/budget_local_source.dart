import 'dart:async';

import 'package:expense_tracker/feature/budget/data/local/budget_local_source_interface.dart';
import 'package:expense_tracker/feature/budget/data/model/input/set_budget_input.dart';
import 'package:expense_tracker/feature/budget/data/model/output/budget.dart';
import 'package:expense_tracker/feature/transactions/data/model/entity/transaction_month.dart';
import 'package:sqflite/sqflite.dart';

class BudgetLocalSource implements BudgetLocalSourceInterface {
  BudgetLocalSource(this._db);

  static const _table = 'budgets';

  final Database _db;

  final _streamController = StreamController<Budget>.broadcast();

  @override
  Stream<Budget> get budgetStream => _streamController.stream;

  @override
  Future<Budget?> getBudget(TransactionMonth month) async {
    final result = await _db.query(
      _table,
      where: 'date = ?',
      whereArgs: [month.toIso8601String()],
    );
    final json = result.firstOrNull;

    if (json == null) return null;

    return Budget.fromJson(json);
  }

  @override
  Future<Budget?> getLatestBudget() async {
    final result = await _db.query(
      _table,
      orderBy: 'modified_at DESC',
      limit: 1,
    );

    final json = result.firstOrNull;

    if (json == null) return null;

    return Budget.fromJson(json);
  }

  @override
  Future<void> setBudget(SetBudgetInput input) async {
    final date = input.month.toIso8601String();
    final budget = input.amount;

    final existing = await getBudget(input.month);

    if (budget == null || budget <= 0) {
      await _db.delete(
        _table,
        where: 'date = ?',
        whereArgs: [date],
      );
    } else if (existing == null) {
      await _db.insert(
        _table,
        input.toJson(),
      );
    } else {
      await _db.update(
        _table,
        {'amount': budget},
        where: 'date = ?',
        whereArgs: [date],
      );
    }

    _streamController.add(
      Budget(
        month: input.month,
        amount: budget,
      ),
    );
  }

  void dispose() {
    _streamController.close();
  }
}
