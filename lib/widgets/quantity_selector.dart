import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrease,
            icon: const Icon(
              Icons.remove,
              size: 17,
            ),
            constraints: const BoxConstraints(
              minWidth: 34,
              minHeight: 34,
            ),
            padding: EdgeInsets.zero,
          ),

          Text(
            '$quantity',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),

          IconButton(
            onPressed: onIncrease,
            icon: const Icon(
              Icons.add,
              size: 17,
            ),
            constraints: const BoxConstraints(
              minWidth: 34,
              minHeight: 34,
            ),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}