import 'package:sqflite/sqflite.dart';

import '../../models/product.dart';
import 'app_database.dart';

class ProductLocalDataSource {
  final AppDatabase _database;

  ProductLocalDataSource({
    AppDatabase? database,
  }) : _database = database ?? AppDatabase.instance;

  Future<List<Product>> getProducts() async {
    final db = await _database.database;

    final result = await db.query(
      AppDatabase.productsTable,
      orderBy: 'id ASC',
    );

    return result
        .map(
          (map) => Product.fromMap(map),
    )
        .toList();
  }

  Future<void> insertProducts(
      List<Product> products,
      ) async {
    final db = await _database.database;

    final batch = db.batch();

    for (final product in products) {
      batch.insert(
        AppDatabase.productsTable,
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(
      noResult: true,
    );
  }

  Future<int> getProductCount() async {
    final db = await _database.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count '
          'FROM ${AppDatabase.productsTable}',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> deleteAllProducts() async {
    final db = await _database.database;

    await db.delete(
      AppDatabase.productsTable,
    );
  }
}