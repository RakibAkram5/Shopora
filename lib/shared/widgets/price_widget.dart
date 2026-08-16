import 'package:flutter/material.dart';
import 'package:shopora/core/constants/app_constants.dart';

class PriceWidget extends StatelessWidget {
  final double price;
  final double? discountPrice;
  final double fontSize;
  final bool isVertical;

  const PriceWidget({
    Key? key,
    required this.price,
    this.discountPrice,
    this.fontSize = 16,
    this.isVertical = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasDiscount = discountPrice != null && discountPrice! < price;
    final effectivePrice = discountPrice ?? price;

    if (isVertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppConstants.currencySymbol}${effectivePrice.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          if (hasDiscount) ...[
            const SizedBox(height: 2),
            Text(
              '${AppConstants.currencySymbol}${price.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: fontSize * 0.8,
                decoration: TextDecoration.lineThrough,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      );
    }

    return Row(
      children: [
        Text(
          '${AppConstants.currencySymbol}${effectivePrice.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        if (hasDiscount) ...[
          const SizedBox(width: 8),
          Text(
            '${AppConstants.currencySymbol}${price.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: fontSize * 0.85,
              decoration: TextDecoration.lineThrough,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
