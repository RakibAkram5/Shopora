import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopora/core/constants/app_constants.dart';
import 'package:shopora/features/cart/presentation/cart_controller.dart';
import 'package:shopora/features/orders/presentation/orders_controller.dart';
import 'package:shopora/features/checkout/presentation/order_success_screen.dart';
import 'package:shopora/shared/models/address_model.dart';
import 'package:shopora/shared/models/order_model.dart';
import 'package:shopora/shared/widgets/app_button.dart';
import 'package:shopora/shared/widgets/address_card.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int _selectedPaymentMethod = 0; // 0: COD, 1: Credit Card, 2: Digital Wallet
  final List<String> _paymentMethods = ['Cash on Delivery', 'Credit/Debit Card', 'Digital Wallet'];

  final AddressModel _defaultAddress = AddressModel(
    id: 'addr_1',
    fullName: 'Rakib Akram',
    phone: '+8801700000000',
    address: 'House 42, Road 11, Banani',
    city: 'Dhaka',
    area: 'Banani',
    postalCode: '1213',
    addressType: 'Home',
    isDefault: true,
  );

  bool _isLoading = false;

  void _placeOrder() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    final cartItems = ref.read(cartControllerProvider);
    final cartNotifier = ref.read(cartControllerProvider.notifier);

    final orderItems = cartItems
        .where((item) => item.isSelected)
        .map((item) => OrderItem(
              productId: item.productId,
              productName: item.productName,
              productImage: item.productImage,
              price: item.effectivePrice,
              quantity: item.quantity,
              size: item.selectedSize,
              color: item.selectedColor,
            ))
        .toList();

    final newOrder = OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
      userId: 'user_001',
      items: orderItems,
      subtotal: cartNotifier.subtotal,
      discount: cartNotifier.discount,
      deliveryFee: cartNotifier.deliveryFee,
      total: cartNotifier.total,
      address: _defaultAddress,
      paymentMethod: _paymentMethods[_selectedPaymentMethod],
      orderStatus: 'Confirmed',
      createdAt: DateTime.now(),
      estimatedDelivery: DateTime.now().add(const Duration(days: 3)),
    );

    ref.read(ordersControllerProvider.notifier).addOrder(newOrder);
    cartNotifier.clearCart();

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => OrderSuccessScreen(order: newOrder)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = ref.watch(cartControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),
            AddressCard(
              address: _defaultAddress,
              isSelected: true,
              onTap: () {},
            ),
            const SizedBox(height: 24),
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),
            ...List.generate(_paymentMethods.length, (index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _selectedPaymentMethod == index
                        ? AppColors.primary
                        : const Color(0xFFE2E0EC),
                    width: _selectedPaymentMethod == index ? 2 : 1,
                  ),
                ),
                child: RadioListTile<int>(
                  title: Text(
                    _paymentMethods[index],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  value: index,
                  groupValue: _selectedPaymentMethod,
                  activeColor: AppColors.primary,
                  onChanged: (val) {
                    setState(() => _selectedPaymentMethod = val!);
                  },
                ),
              );
            }),
            const SizedBox(height: 24),
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal', style: TextStyle(color: AppColors.textSecondary)),
                      Text('${AppConstants.currencySymbol}${cartNotifier.subtotal.toStringAsFixed(0)}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Discount', style: TextStyle(color: AppColors.textSecondary)),
                      Text('-${AppConstants.currencySymbol}${cartNotifier.discount.toStringAsFixed(0)}', style: const TextStyle(color: AppColors.discount)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Delivery', style: TextStyle(color: AppColors.textSecondary)),
                      Text('${AppConstants.currencySymbol}${cartNotifier.deliveryFee.toStringAsFixed(0)}'),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('${AppConstants.currencySymbol}${cartNotifier.total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            AppButton(
              text: 'Place Order',
              isLoading: _isLoading,
              onPressed: _placeOrder,
            ),
          ],
        ),
      ),
    );
  }
}
