import 'dart:async';

import 'package:flutter/material.dart';
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
      version: 2,
      onCreate: _createDatabase,
      onUpgrade: (db, oldVer, newVer) async {
        if (oldVer < 2) {
          final currentDate = DateTime.now().toIso8601String();

          await db.execute(
            '''
              ALTER TABLE transactions
              ADD COLUMN created_at TEXT NOT NULL DEFAULT '$currentDate'
            ''',
          );

          _upgradeDbMessage(2);
        }
      },
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
          category TEXT NOT NULL,
          created_at TEXT NOT NULL
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
          modified_at TEXT NOT NULL,
          UNIQUE(date)
        )
      ''',
    );
  }

  void _upgradeDbMessage(int version) => debugPrint(
        'Database upgraded to version $version',
      );

  // Close the database and stream controllers
  Future<void> close() async {
    await database.close();
  }
}
