import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository;

  ProductViewModel({
    ProductRepository? repository,
  }) : _repository = repository ?? ProductRepository();

  List<Product> _products = [];

  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _sortOption = 'Featured';

  final Set<int> _wishlistIds = {};

  bool _isLoading = false;
  String? _errorMessage;

  // ==========================================================
  // GETTERS
  // ==========================================================

  List<Product> get products {
    return List.unmodifiable(_products);
  }

  String get searchQuery => _searchQuery;

  String get selectedCategory => _selectedCategory;

  String get sortOption => _sortOption;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  // ==========================================================
  // CATEGORIES
  // ==========================================================

  List<String> get categories {
    return [
      'All',
      ..._products
          .map((product) => product.category)
          .toSet(),
    ];
  }

  // ==========================================================
  // FEATURED PRODUCTS
  // ==========================================================

  List<Product> get featuredProducts {
    return _products
        .where((product) => product.isFeatured)
        .toList();
  }

  // ==========================================================
  // FILTERED + SORTED PRODUCTS
  // ==========================================================

  List<Product> get filteredProducts {
    List<Product> result = _products.where((product) {
      final matchesSearch = product.name
          .toLowerCase()
          .contains(
        _searchQuery.toLowerCase(),
      );

      final matchesCategory =
          _selectedCategory == 'All' ||
              product.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    switch (_sortOption) {
      case 'Price: Low to High':
        result.sort(
              (a, b) => a.price.compareTo(b.price),
        );
        break;

      case 'Price: High to Low':
        result.sort(
              (a, b) => b.price.compareTo(a.price),
        );
        break;

      case 'Rating':
        result.sort(
              (a, b) => b.rating.compareTo(a.rating),
        );
        break;

      case 'Featured':
      default:
        result.sort((a, b) {
          if (a.isFeatured == b.isFeatured) {
            return 0;
          }

          return a.isFeatured ? -1 : 1;
        });
    }

    return result;
  }

  // ==========================================================
  // LOAD PRODUCTS FROM SQLITE
  // ==========================================================

  Future<void> loadProducts() async {
    _isLoading = true;
    _errorMessage = null;

    notifyListeners();

    try {
      _products = await _repository.getProducts();
    } catch (e) {
      _errorMessage = 'Failed to load products.';
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  // ==========================================================
  // SEARCH
  // ==========================================================

  void setSearchQuery(String value) {
    _searchQuery = value;

    notifyListeners();
  }

  // ==========================================================
  // CATEGORY
  // ==========================================================

  void setCategory(String category) {
    _selectedCategory = category;

    notifyListeners();
  }

  // ==========================================================
  // SORT
  // ==========================================================

  void setSortOption(String option) {
    _sortOption = option;

    notifyListeners();
  }

  // ==========================================================
  // CLEAR FILTERS
  // ==========================================================

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = 'All';
    _sortOption = 'Featured';

    notifyListeners();
  }

  // ==========================================================
  // WISHLIST
  // ==========================================================

  void toggleWishlist(int productId) {
    if (_wishlistIds.contains(productId)) {
      _wishlistIds.remove(productId);
    } else {
      _wishlistIds.add(productId);
    }

    notifyListeners();
  }

  bool isWishlisted(int productId) {
    return _wishlistIds.contains(productId);
  }

  int get wishlistCount {
    return _wishlistIds.length;
  }
}