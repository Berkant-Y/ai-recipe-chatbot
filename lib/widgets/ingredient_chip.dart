import 'package:flutter/material.dart';

class IngredientChip extends StatelessWidget {
  final String ingredient;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const IngredientChip({
    Key? key,
    required this.ingredient,
    this.isSelected = false,
    this.onTap,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 8, bottom: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_dining,
              size: 16,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            SizedBox(width: 6),
            Text(
              ingredient,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            if (onRemove != null) ...[
              SizedBox(width: 6),
              GestureDetector(
                onTap: onRemove,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: isSelected ? Colors.white : Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}