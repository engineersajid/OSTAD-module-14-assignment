import 'package:sqflite/sqflite.dart';

import '../../models/cart_item.dart';
import '../../models/product.dart';
import 'app_database.dart';

class CartLocalDataSource {
  final AppDatabase _database;

  CartLocalDataSource({
    AppDatabase? database,
  }) : _database =
      database ?? AppDatabase.instance;

  Future<List<CartItem>> getCartItems() async {
    final db = await _database.database;

    final result = await db.rawQuery('''
      SELECT
        p.id,
        p.name,
        p.description,
        p.price,
        p.category,
        p.image_url,
        p.rating,
        p.review_count,
        p.is_featured,
        c.quantity
      FROM ${AppDatabase.cartItemsTable} c
      INNER JOIN ${AppDatabase.productsTable} p
        ON c.product_id = p.id
      ORDER BY c.product_id ASC
    ''');

    return result.map((map) {
      final product = Product.fromMap(map);

      return CartItem(
        product: product,
        quantity: map['quantity'] as int,
      );
    }).toList();
  }

  Future<void> addOrIncreaseItem(
      Product product,
      ) async {
    final db = await _database.database;

    await db.rawInsert(
      '''
      INSERT INTO ${AppDatabase.cartItemsTable}
      (
        product_id,
        quantity
      )
      VALUES (?, 1)
      ON CONFLICT(product_id)
      DO UPDATE SET quantity = quantity + 1
      ''',
      [
        product.id,
      ],
    );
  }

  Future<void> increaseQuantity(
      int productId,
      ) async {
    final db = await _database.database;

    await db.rawUpdate(
      '''
      UPDATE ${AppDatabase.cartItemsTable}
      SET quantity = quantity + 1
      WHERE product_id = ?
      ''',
      [
        productId,
      ],
    );
  }

  Future<void> decreaseQuantity(
      int productId,
      ) async {
    final db = await _database.database;

    await db.rawUpdate(
      '''
      UPDATE ${AppDatabase.cartItemsTable}
      SET quantity = quantity - 1
      WHERE product_id = ?
      AND quantity > 1
      ''',
      [
        productId,
      ],
    );
  }

  Future<void> removeItem(
      int productId,
      ) async {
    final db = await _database.database;

    await db.delete(
      AppDatabase.cartItemsTable,
      where: 'product_id = ?',
      whereArgs: [
        productId,
      ],
    );
  }

  Future<void> clearCart() async {
    final db = await _database.database;

    await db.delete(
      AppDatabase.cartItemsTable,
    );
  }
}