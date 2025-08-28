import 'dart:async';

import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

const _databaseFile = 'buckie_database.db';
const _tableCreateStatements = [
  '''
    CREATE TABLE categories(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL CHECK(name <> ''),
      icon TEXT NOT NULL,
      color TEXT NOT NULL,
      is_default INTEGER NOT NULL,
      UNIQUE(name)
    )
  ''',
  '''
    CREATE TABLE transactions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount REAL NOT NULL,
      remarks TEXT,
      date TEXT NOT NULL,
      created_at TEXT NOT NULL,
      category_id INTEGER,
      FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
    )
  ''',
  '''
    CREATE TABLE budgets(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      amount REAL NOT NULL,
      modified_at TEXT NOT NULL,
      UNIQUE(date)
    )
  ''',
];

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  late Database _database;

  /// Database must be initialized first or exception will be thrown.
  Database get database => _database;

  Future<void> initDatabase() async {
    final path = '${await getDatabasesPath()}/$_databaseFile';

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
      onUpgrade: _onUpgrade,
    );
  }

  FutureOr<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');

    if (kDebugMode) debugPrintDatabaseStructure(db);
  }

  Future<void> _onUpgrade(
    Database db,
    int oldVer,
    int newVer,
  ) async {}

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    // Create tables
    for (final statement in _tableCreateStatements) {
      await db.execute(statement);
    }

    // Insert seed categories
    for (final category in CategoryDetails.defaultCategories) {
      await db.insert(
        'categories',
        category.toJson(withId: false),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // ignore: unused_element
  void _upgradeDbMessage(int version) => debugPrint(
        'Database upgraded to version $version',
      );

  Future<void> debugPrintDatabaseStructure(Database db) async {
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name;",
    );

    for (var table in tables) {
      final tableName = table['name'] as String;
      print('🔹 Table: $tableName');

      final columns = await db.rawQuery('PRAGMA table_info($tableName);');
      for (var col in columns) {
        print("   • ${col['name']} (${col['type']}) "
            "${col['notnull'] == 1 ? 'NOT NULL' : ''} "
            "${col['pk'] == 1 ? 'PRIMARY KEY' : ''}");
      }

      final fks = await db.rawQuery('PRAGMA foreign_key_list($tableName);');
      for (var fk in fks) {
        print("   ↳ FK: ${fk['from']} → ${fk['table']}(${fk['to']}) "
            "onUpdate=${fk['on_update']} onDelete=${fk['on_delete']}");
      }

      print('');
    }
  }

  Future<void> close() async {
    await database.close();
  }
}
