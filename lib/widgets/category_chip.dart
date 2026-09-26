import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  IconData _getIcon() {
    switch (label) {
      case 'Electronics':
        return Icons.devices_outlined;

      case 'Fashion':
        return Icons.checkroom_outlined;

      case 'Home':
        return Icons.home_outlined;

      case 'Beauty':
        return Icons.face_retouching_natural;

      case 'Sports':
        return Icons.sports_soccer_outlined;

      case 'Accessories':
        return Icons.watch_outlined;

      default:
        return Icons.grid_view_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getIcon(),
              size: 17,
              color: selected
                  ? Colors.white
                  : AppColors.textSecondary,
            ),

            const SizedBox(width: 7),

            Text(
              label,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}