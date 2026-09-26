import 'package:flutter/foundation.dart';

import '../core/constants/app_constants.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../repositories/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository _repository;

  CartProvider({
    CartRepository? repository,
  }) : _repository =
      repository ?? CartRepository();

  final Map<int, CartItem> _items = {};

  bool _isLoading = false;

  String? _errorMessage;

  List<CartItem> get items => _items.values.toList();

  bool get isEmpty => _items.isEmpty;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  int get totalItems {
    return _items.values.fold(
      0,
          (total, item) => total + item.quantity,
    );
  }

  double get subtotal {
    return _items.values.fold(
      0,
          (total, item) => total + item.totalPrice,
    );
  }

  double get discount {
    if (subtotal > AppConstants.discountThreshold) {
      return subtotal *
          AppConstants.discountPercentage;
    }

    return 0;
  }

  double get finalTotal {
    return subtotal - discount;
  }

  bool get isEligibleForFreeDelivery {
    return subtotal >=
        AppConstants.freeDeliveryThreshold;
  }

  Future<void> loadCart() async {
    _isLoading = true;
    _errorMessage = null;

    notifyListeners();

    try {
      final cartItems =
      await _repository.getCartItems();

      _items.clear();

      for (final item in cartItems) {
        _items[item.product.id] = item;
      }
    } catch (e) {
      _errorMessage = 'Failed to load cart.';
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> addToCart(
      Product product,
      ) async {
    await _repository.addToCart(
      product,
    );

    final existingItem =
    _items[product.id];

    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      _items[product.id] = CartItem(
        product: product,
        quantity: 1,
      );
    }

    notifyListeners();
  }

  Future<void> increaseQuantity(
      int productId,
      ) async {
    final item = _items[productId];

    if (item == null) {
      return;
    }

    await _repository.increaseQuantity(
      productId,
    );

    item.quantity++;

    notifyListeners();
  }

  Future<void> decreaseQuantity(
      int productId,
      ) async {
    final item = _items[productId];

    if (item == null) {
      return;
    }

    if (item.quantity > 1) {
      await _repository.decreaseQuantity(
        productId,
      );

      item.quantity--;
    } else {
      await _repository.removeFromCart(
        productId,
      );

      _items.remove(productId);
    }

    notifyListeners();
  }

  Future<void> removeFromCart(
      int productId,
      ) async {
    await _repository.removeFromCart(
      productId,
    );

    _items.remove(productId);

    notifyListeners();
  }

  Future<void> clearCart() async {
    await _repository.clearCart();

    _items.clear();

    notifyListeners();
  }

  int quantityOf(int productId) {
    return _items[productId]?.quantity ?? 0;
  }
}