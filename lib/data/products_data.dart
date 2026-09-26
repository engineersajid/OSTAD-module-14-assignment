import '../models/product.dart';

const List<Product> products = [
  // ==================================================
  // ELECTRONICS
  // ==================================================

  Product(
    id: 1,
    name: 'Wireless Headphones',
    description:
    'Premium wireless headphones with immersive sound and comfortable ear cushions.',
    price: 2500,
    category: 'Electronics',
    imageUrl:
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
    rating: 4.8,
    reviewCount: 324,
    isFeatured: true,
  ),

  Product(
    id: 2,
    name: 'Smart Watch Pro',
    description:
    'Modern smartwatch with fitness tracking, notifications and long battery life.',
    price: 4200,
    category: 'Electronics',
    imageUrl:
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
    rating: 4.7,
    reviewCount: 218,
    isFeatured: true,
  ),

  Product(
    id: 3,
    name: 'Wireless Speaker',
    description:
    'Portable Bluetooth speaker with powerful audio and compact design.',
    price: 1800,
    category: 'Electronics',
    imageUrl:
    'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1',
    rating: 4.6,
    reviewCount: 156,
  ),

  Product(
    id: 4,
    name: 'Minimal Desk Setup',
    description:
    'Clean and modern desktop accessory designed for productive workspaces.',
    price: 3200,
    category: 'Electronics',
    imageUrl:
    'https://images.unsplash.com/photo-1496181133206-80ce9b88a853',
    rating: 4.5,
    reviewCount: 98,
  ),

  // ==================================================
  // FASHION
  // ==================================================

  Product(
    id: 5,
    name: 'Classic White T-Shirt',
    description:
    'Premium cotton t-shirt with a comfortable regular fit.',
    price: 850,
    category: 'Fashion',
    imageUrl:
    'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab',
    rating: 4.7,
    reviewCount: 412,
    isFeatured: true,
  ),

  Product(
    id: 6,
    name: 'Denim Jacket',
    description:
    'Classic denim jacket suitable for casual everyday outfits.',
    price: 2400,
    category: 'Fashion',
    imageUrl:
    'https://images.unsplash.com/photo-1551028719-00167b16eac5',
    rating: 4.6,
    reviewCount: 187,
  ),

  Product(
    id: 7,
    name: 'Premium Sneakers',
    description:
    'Comfortable everyday sneakers with a modern minimal design.',
    price: 3500,
    category: 'Fashion',
    imageUrl:
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
    rating: 4.9,
    reviewCount: 521,
    isFeatured: true,
  ),

  Product(
    id: 8,
    name: 'Classic Backpack',
    description:
    'Durable backpack with multiple compartments for everyday use.',
    price: 1600,
    category: 'Fashion',
    imageUrl:
    'https://images.unsplash.com/photo-1553062407-98eeb64c6a62',
    rating: 4.5,
    reviewCount: 143,
  ),

  // ==================================================
  // HOME & LIVING
  // ==================================================

  Product(
    id: 9,
    name: 'Modern Table Lamp',
    description:
    'Elegant table lamp that adds warmth and style to your workspace.',
    price: 1200,
    category: 'Home',
    imageUrl:
    'https://images.unsplash.com/photo-1507473885765-e6ed057f782c',
    rating: 4.6,
    reviewCount: 122,
  ),

  Product(
    id: 10,
    name: 'Modern Chair',
    description:
    'Comfortable modern chair designed for home and office spaces.',
    price: 5200,
    category: 'Home',
    imageUrl:
    'https://images.unsplash.com/photo-1503602642458-232111445657',
    rating: 4.8,
    reviewCount: 89,
    isFeatured: true,
  ),

  Product(
    id: 11,
    name: 'Coffee Maker',
    description:
    'Compact coffee maker for preparing delicious coffee at home.',
    price: 3800,
    category: 'Home',
    imageUrl:
    'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085',
    rating: 4.7,
    reviewCount: 205,
  ),

  Product(
    id: 12,
    name: 'Minimal Sofa',
    description:
    'Comfortable contemporary sofa with a clean and elegant appearance.',
    price: 12500,
    category: 'Home',
    imageUrl:
    'https://images.unsplash.com/photo-1555041469-a586c61ea9bc',
    rating: 4.8,
    reviewCount: 76,
  ),

  // ==================================================
  // BEAUTY
  // ==================================================

  Product(
    id: 13,
    name: 'Skincare Set',
    description:
    'Daily skincare essentials packaged as a complete beauty set.',
    price: 2200,
    category: 'Beauty',
    imageUrl:
    'https://images.unsplash.com/photo-1556228578-8c89e6adf883',
    rating: 4.7,
    reviewCount: 267,
    isFeatured: true,
  ),

  Product(
    id: 14,
    name: 'Perfume Collection',
    description:
    'Elegant fragrance collection with sophisticated everyday scents.',
    price: 2800,
    category: 'Beauty',
    imageUrl:
    'https://images.unsplash.com/photo-1541643600914-78b084683601',
    rating: 4.8,
    reviewCount: 198,
  ),

  Product(
    id: 15,
    name: 'Makeup Essentials',
    description:
    'A stylish collection of essential makeup products.',
    price: 1900,
    category: 'Beauty',
    imageUrl:
    'https://images.unsplash.com/photo-1596462502278-27bfdc403348',
    rating: 4.5,
    reviewCount: 154,
  ),

  // ==================================================
  // SPORTS
  // ==================================================

  Product(
    id: 16,
    name: 'Running Shoes Pro',
    description:
    'Lightweight running shoes designed for comfortable daily workouts.',
    price: 4200,
    category: 'Sports',
    imageUrl:
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
    rating: 4.9,
    reviewCount: 432,
    isFeatured: true,
  ),

  Product(
    id: 17,
    name: 'Fitness Watch',
    description:
    'Track workouts, steps and daily activity with this fitness watch.',
    price: 3900,
    category: 'Sports',
    imageUrl:
    'https://images.unsplash.com/photo-1552674605-db6ffd4facb5',
    rating: 4.6,
    reviewCount: 176,
  ),

  Product(
    id: 18,
    name: 'Yoga Mat',
    description:
    'Comfortable non-slip yoga mat for home workouts and exercise.',
    price: 1100,
    category: 'Sports',
    imageUrl:
    'https://images.unsplash.com/photo-1592432678016-e910b452f9a2',
    rating: 4.7,
    reviewCount: 291,
  ),

  // ==================================================
  // ACCESSORIES
  // ==================================================

  Product(
    id: 19,
    name: 'Leather Wallet',
    description:
    'Classic compact wallet made for everyday convenience.',
    price: 1300,
    category: 'Accessories',
    imageUrl:
    'https://images.unsplash.com/photo-1627123424574-724758594e93',
    rating: 4.6,
    reviewCount: 143,
  ),

  Product(
    id: 20,
    name: 'Classic Sunglasses',
    description:
    'Modern sunglasses with a timeless everyday design.',
    price: 1700,
    category: 'Accessories',
    imageUrl:
    'https://images.unsplash.com/photo-1511499767150-a48a237f0083',
    rating: 4.7,
    reviewCount: 214,
    isFeatured: true,
  ),
];