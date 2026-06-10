import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/character_model.dart';

class AppDatabase {
  static const String _databaseName = 'character_explorer.db';
  static const int _databaseVersion = 1;

  static const String favoritesTable = 'favorite_characters';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $favoritesTable (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        status TEXT NOT NULL,
        species TEXT NOT NULL,
        type TEXT NOT NULL,
        gender TEXT NOT NULL,
        originName TEXT NOT NULL,
        locationName TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        episodes TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertFavorite(CharacterModel character) async {
    final db = await database;

    await db.insert(
      favoritesTable,
      character.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(int id) async {
    final db = await database;

    await db.delete(
      favoritesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isFavorite(int id) async {
    final db = await database;

    final result = await db.query(
      favoritesTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<List<CharacterModel>> getFavorites() async {
    final db = await database;

    final result = await db.query(
      favoritesTable,
      orderBy: 'name ASC',
    );

    return result.map((map) => CharacterModel.fromMap(map)).toList();
  }
}