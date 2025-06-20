import 'dart:async';

import 'package:sqflite/sqflite.dart';

const _kDatabaseFile = 'buckie_database.db';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  late Database _database;

  /// Database must be initialized first
  Database get database => _database;

  Future<void> initDatabase() async {
    final path = '${await getDatabasesPath()}/$_kDatabaseFile';

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(
    Database db,
    int version,
  ) async {
    // Create transactions table
    await db.execute(
      '''
        CREATE TABLE transactions(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          amount REAL NOT NULL,
          remarks TEXT,
          date TEXT NOT NULL,
          category TEXT NOT NULL
        )
      ''',
    );

    // Create monthly_budgets table
    await db.execute(
      '''
        CREATE TABLE monthly_budgets(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT NOT NULL,
          amount REAL NOT NULL,
          UNIQUE(date)
        )
      ''',
    );
  }

  // Close the database and stream controllers
  Future<void> close() async {
    await database.close();
  }
}
