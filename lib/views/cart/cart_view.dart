import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../models/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/quantity_selector.dart';
import '../home/home_view.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (!cart.isEmpty)
            TextButton(
              onPressed: () {
                _showClearDialog(context);
              },
              child: const Text(
                'Clear',
                style: TextStyle(
                  color: AppColors.danger,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),

      body: cart.isEmpty
          ? const _EmptyCart()
          : Column(
        children: [
          if (cart.isEligibleForFreeDelivery)
            const _FreeDeliveryBanner()
          else
            _DeliveryProgress(
              subtotal: cart.subtotal,
            ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cart.items.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = cart.items[index];

                return _CartItemCard(
                  item: item,
                );
              },
            ),
          ),

          const _CartSummary(),
        ],
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Clear Cart?'),
          content: const Text(
            'All products will be removed from your cart.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<CartProvider>()
                    .clearCart();

                Navigator.pop(dialogContext);
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }
}

// =====================================================
// CART ITEM
// =====================================================

class _CartItemCard extends StatelessWidget {
  final CartItem item;

  const _CartItemCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(13),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.network(
                item.product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_outlined,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  '${AppConstants.currency}${item.product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 9),

                QuantitySelector(
                  quantity: item.quantity,
                  onIncrease: () {
                    cart.increaseQuantity(
                      item.product.id,
                    );
                  },
                  onDecrease: () {
                    cart.decreaseQuantity(
                      item.product.id,
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(width: 5),

          Column(
            crossAxisAlignment:
            CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  cart.removeFromCart(
                    item.product.id,
                  );
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppColors.danger,
                  size: 21,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                '${AppConstants.currency}${item.totalPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================
// FREE DELIVERY
// =====================================================

class _FreeDeliveryBanner extends StatelessWidget {
  const _FreeDeliveryBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        16,
        5,
        16,
        0,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(13),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.local_shipping_outlined,
            color: AppColors.success,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Congratulations! You qualify for free delivery.',
              style: TextStyle(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// DELIVERY PROGRESS
// =====================================================

class _DeliveryProgress extends StatelessWidget {
  final double subtotal;

  const _DeliveryProgress({
    required this.subtotal,
  });

  @override
  Widget build(BuildContext context) {
    final remaining =
        AppConstants.freeDeliveryThreshold -
            subtotal;

    final progress =
    (subtotal /
        AppConstants.freeDeliveryThreshold)
        .clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.fromLTRB(
        16,
        5,
        16,
        0,
      ),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            'Add ৳${remaining.toStringAsFixed(0)} more for FREE delivery',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor:
              Colors.grey.shade200,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// CART SUMMARY
// =====================================================

class _CartSummary extends StatelessWidget {
  const _CartSummary();

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        20,
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            _SummaryRow(
              title: 'Total Items',
              value: '${cart.totalItems}',
            ),

            const SizedBox(height: 7),

            _SummaryRow(
              title: 'Subtotal',
              value:
              '৳${cart.subtotal.toStringAsFixed(0)}',
            ),

            const SizedBox(height: 7),

            _SummaryRow(
              title: 'Discount',
              value:
              '- ৳${cart.discount.toStringAsFixed(0)}',
              valueColor: AppColors.success,
            ),

            const Divider(height: 22),

            _SummaryRow(
              title: 'Final Total',
              value:
              '৳${cart.finalTotal.toStringAsFixed(0)}',
              titleStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              valueStyle: const TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showCheckoutDialog(context);
                },
                icon: const Icon(
                  Icons.lock_outline,
                  size: 18,
                ),
                label: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Order Ready'),
          content: const Text(
            'This is a demo checkout because this assignment does not use a backend or payment system.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }
}

// =====================================================
// SUMMARY ROW
// =====================================================

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const _SummaryRow({
    required this.title,
    required this.value,
    this.valueColor,
    this.titleStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle ??
              const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
        ),
        Text(
          value,
          style: valueStyle ??
              TextStyle(
                color: valueColor ??
                    AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
        ),
      ],
    );
  }
}

// =====================================================
// EMPTY CART
// =====================================================

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 65,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Looks like you have not added anything to your cart yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const HomeView(),
                  ),
                      (route) => false,
                );
              },
              icon: const Icon(
                Icons.explore_outlined,
              ),
              label: const Text(
                'Explore Products',
              ),
            ),
          ],
        ),
      ),
    );
  }
}