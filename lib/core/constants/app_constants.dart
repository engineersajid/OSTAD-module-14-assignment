class AppConstants {
  AppConstants._();

  // App
  static const String appName =  'ShopEase';
  static const String appTagline = 'Discover something you love';

  // Currency
  static const String currency = '৳';

  // Cart & Discount
  static const double discountThreshold = 2000.0;
  static const double discountPercentage = 0.10;

  // Delivery
  static const double freeDeliveryThreshold = 3000.0;

  // Product
  static const int productsPerRow = 2;

  // UI
  static const double defaultPadding = 16.0;
  static const double cardRadius = 18.0;
  static const double buttonRadius = 14.0;
  static const double smallRadius = 10.0;

  // Animation
  static const Duration defaultAnimationDuration =
  Duration(milliseconds: 200);
}