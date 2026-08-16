import 'package:flutter/material.dart';
import 'package:shopora/core/constants/app_constants.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;

  const OrderStatusWidget({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toLowerCase()) {
      case 'delivered':
        color = AppColors.success;
        break;
      case 'shipped':
      case 'processing':
      case 'confirmed':
        color = AppColors.primary;
        break;
      case 'cancelled':
        color = AppColors.error;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
