import 'package:flutter/material.dart';
import 'package:shopora/core/constants/app_constants.dart';
import 'package:shopora/shared/models/order_model.dart';

class OrderTrackingScreen extends StatelessWidget {
  final OrderModel order;

  const OrderTrackingScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final steps = ['Order Placed', 'Confirmed', 'Processing', 'Shipped', 'Delivered'];
    int currentStep = 2; // Default processing
    if (order.orderStatus == 'Confirmed') currentStep = 1;
    if (order.orderStatus == 'Shipped') currentStep = 3;
    if (order.orderStatus == 'Delivered') currentStep = 4;

    return Scaffold(
      appBar: AppBar(title: Text('Track Order ${order.id}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID: ${order.id}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Total: ${AppConstants.currencySymbol}${order.total.toStringAsFixed(0)}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Delivery Address: ${order.address.address}, ${order.address.city}', style: const TextStyle(color: AppColors.textSecondary)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Order Timeline',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            ...List.generate(steps.length, (index) {
              final isCompleted = index <= currentStep;
              return Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isCompleted ? AppColors.success : const Color(0xFFE2E0EC),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isCompleted ? Icons.check : Icons.circle,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      if (index < steps.length - 1)
                        Container(
                          width: 2,
                          height: 40,
                          color: index < currentStep ? AppColors.success : const Color(0xFFE2E0EC),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Text(
                    steps[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                      color: isCompleted ? AppColors.textPrimary : AppColors.textSecondary,
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
