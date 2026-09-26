import 'package:flutter/foundation.dart';

import '../core/constants/app_constants.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  bool get isEmpty => _items.isEmpty;

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
      return subtotal * AppConstants.discountPercentage;
    }

    return 0;
  }

  double get finalTotal {
    return subtotal - discount;
  }

  bool get isEligibleForFreeDelivery {
    return subtotal >= AppConstants.freeDeliveryThreshold;
  }

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(
        product: product,
      );
    }

    notifyListeners();
  }

  void increaseQuantity(int productId) {
    final item = _items[productId];

    if (item == null) {
      return;
    }

    item.quantity++;

    notifyListeners();
  }

  void decreaseQuantity(int productId) {
    final item = _items[productId];

    if (item == null) {
      return;
    }

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  void removeFromCart(int productId) {
    _items.remove(productId);

    notifyListeners();
  }

  void clearCart() {
    _items.clear();

    notifyListeners();
  }

  int quantityOf(int productId) {
    return _items[productId]?.quantity ?? 0;
  }
}