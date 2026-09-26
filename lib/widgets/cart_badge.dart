import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../providers/cart_provider.dart';

class CartBadge extends StatelessWidget {
  final VoidCallback onPressed;

  const CartBadge({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.shopping_bag_outlined,
          ),
        ),

        if (cart.totalItems > 0)
          Positioned(
            right: 3,
            top: 4,
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 19,
                minHeight: 19,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              decoration: const BoxDecoration(
                color: AppColors.danger,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${cart.totalItems}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}