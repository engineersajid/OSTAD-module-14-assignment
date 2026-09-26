import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._privateConstructor();

  static final AppDatabase instance =
  AppDatabase._privateConstructor();

  static Database? _database;

  static const String _databaseName = 'shopease.db';
  static const int _databaseVersion = 2;

  static const String productsTable = 'products';
  static const String cartItemsTable = 'cart_items';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      _databaseName,
    );

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(
      Database db,
      int version,
      ) async {
    await db.execute('''
      CREATE TABLE $productsTable (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        price REAL NOT NULL,
        category TEXT NOT NULL,
        image_url TEXT NOT NULL,
        rating REAL NOT NULL,
        review_count INTEGER NOT NULL,
        is_featured INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $cartItemsTable (
        product_id INTEGER PRIMARY KEY,
        quantity INTEGER NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE $cartItemsTable (
          product_id INTEGER PRIMARY KEY,
          quantity INTEGER NOT NULL
        )
      ''');
    }
  }
}