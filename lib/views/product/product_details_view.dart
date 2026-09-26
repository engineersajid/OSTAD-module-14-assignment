import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../viewmodels/product_view_model.dart';

class ProductDetailsView extends StatelessWidget {
  final Product product;

  const ProductDetailsView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final isWishlisted =
    context.watch<ProductViewModel>().isWishlisted(
      product.id,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              context
                  .read<ProductViewModel>()
                  .toggleWishlist(product.id);
            },
            icon: Icon(
              isWishlisted
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: isWishlisted
                  ? AppColors.danger
                  : AppColors.textPrimary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 330,
              width: double.infinity,
              child: Container(
                color: const Color(0xFFF4F5F7),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_outlined,
                      size: 80,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.warning,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${product.reviewCount} reviews',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(
                    '${AppConstants.currency}${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.6,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 25),

                  _InfoTile(
                    icon: Icons.local_shipping_outlined,
                    title: 'Free Delivery',
                    subtitle:
                    'On orders above ৳3000',
                  ),

                  const SizedBox(height: 10),

                  _InfoTile(
                    icon: Icons.verified_outlined,
                    title: 'Quality Guaranteed',
                    subtitle:
                    'Premium quality products',
                  ),

                  const SizedBox(height: 10),

                  _InfoTile(
                    icon: Icons.assignment_return_outlined,
                    title: 'Easy Returns',
                    subtitle:
                    'Simple return process',
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context
                            .read<CartProvider>()
                            .addToCart(product);

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          const SnackBar(
                            content:
                            Text('Added to cart'),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                      ),
                      label: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}