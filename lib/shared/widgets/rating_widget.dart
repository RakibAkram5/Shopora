import 'package:flutter/material.dart';
import 'package:shopora/core/constants/app_constants.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final double iconSize;

  const RatingWidget({
    Key? key,
    required this.rating,
    this.reviewCount = 0,
    this.iconSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.amber, size: iconSize),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: iconSize * 1.1,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        if (reviewCount > 0) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewCount)',
            style: TextStyle(
              fontSize: iconSize * 0.9,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
