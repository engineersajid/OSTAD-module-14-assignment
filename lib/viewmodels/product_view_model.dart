import 'package:flutter/foundation.dart';

import '../data/products_data.dart';
import '../models/product.dart';

class ProductViewModel extends ChangeNotifier {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _sortOption = 'Featured';

  final Set<int> _wishlistIds = {};

  String get searchQuery => _searchQuery;

  String get selectedCategory => _selectedCategory;

  String get sortOption => _sortOption;

  List<String> get categories {
    return [
      'All',
      ...products.map((product) => product.category).toSet(),
    ];
  }

  List<Product> get featuredProducts {
    return products.where((product) => product.isFeatured).toList();
  }

  List<Product> get filteredProducts {
    List<Product> result = products.where((product) {
      final matchesSearch = product.name
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());

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
        result.sort(
              (a, b) {
            if (a.isFeatured == b.isFeatured) {
              return 0;
            }

            return a.isFeatured ? -1 : 1;
          },
        );
    }

    return result;
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSortOption(String option) {
    _sortOption = option;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = 'All';
    _sortOption = 'Featured';

    notifyListeners();
  }

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

  int get wishlistCount => _wishlistIds.length;
}