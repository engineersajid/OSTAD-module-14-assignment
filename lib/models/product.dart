class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool isFeatured;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    this.isFeatured = false,
  });
}