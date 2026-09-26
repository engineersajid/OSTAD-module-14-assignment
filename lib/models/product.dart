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

  /// Convert Product object into a SQLite-compatible map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'image_url': imageUrl,
      'rating': rating,
      'review_count': reviewCount,
      'is_featured': isFeatured ? 1 : 0,
    };
  }

  /// Create a Product object from a SQLite database row.
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      category: map['category'] as String,
      imageUrl: map['image_url'] as String,
      rating: (map['rating'] as num).toDouble(),
      reviewCount: map['review_count'] as int,
      isFeatured: map['is_featured'] == 1,
    );
  }
}