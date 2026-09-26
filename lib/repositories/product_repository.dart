import '../data/local/product_local_data_source.dart';
import '../data/products_data.dart';
import '../models/product.dart';

class ProductRepository {
  final ProductLocalDataSource _localDataSource;

  ProductRepository({
    ProductLocalDataSource? localDataSource,
  }) : _localDataSource =
      localDataSource ?? ProductLocalDataSource();

  Future<List<Product>> getProducts() async {
    final existingProducts =
    await _localDataSource.getProducts();

    if (existingProducts.isNotEmpty) {
      return existingProducts;
    }

    await _localDataSource.insertProducts(
      products,
    );

    return await _localDataSource.getProducts();
  }

  Future<int> getProductCount() async {
    return await _localDataSource.getProductCount();
  }

  Future<void> insertProducts(
      List<Product> products,
      ) async {
    await _localDataSource.insertProducts(
      products,
    );
  }

  Future<void> deleteAllProducts() async {
    await _localDataSource.deleteAllProducts();
  }
}