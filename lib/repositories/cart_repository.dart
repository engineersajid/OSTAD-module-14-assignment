
import '../data/local/cart_local_data_source.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartRepository {
  final CartLocalDataSource _localDataSource;

  CartRepository({
    CartLocalDataSource? localDataSource,
  }) : _localDataSource =
      localDataSource ?? CartLocalDataSource();

  Future<List<CartItem>> getCartItems() async {
    return await _localDataSource.getCartItems();
  }

  Future<void> addToCart(
      Product product,
      ) async {
    await _localDataSource.addOrIncreaseItem(
      product,
    );
  }

  Future<void> increaseQuantity(
      int productId,
      ) async {
    await _localDataSource.increaseQuantity(
      productId,
    );
  }

  Future<void> decreaseQuantity(
      int productId,
      ) async {
    await _localDataSource.decreaseQuantity(
      productId,
    );
  }

  Future<void> removeFromCart(
      int productId,
      ) async {
    await _localDataSource.removeItem(
      productId,
    );
  }

  Future<void> clearCart() async {
    await _localDataSource.clearCart();
  }
}