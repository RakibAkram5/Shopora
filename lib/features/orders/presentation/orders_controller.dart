import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopora/shared/models/order_model.dart';
import 'package:shopora/shared/models/address_model.dart';

final ordersControllerProvider =
    StateNotifierProvider<OrdersController, List<OrderModel>>((ref) {
  return OrdersController();
});

class OrdersController extends StateNotifier<List<OrderModel>> {
  OrdersController() : super([
    OrderModel(
      id: 'ORD-98421',
      userId: 'user_001',
      items: [
        OrderItem(
          productId: 'prod_1',
          productName: 'AirPods Pro 2',
          productImage: 'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=600',
          price: 69999,
          quantity: 1,
          size: 'Standard',
          color: 'White',
        ),
      ],
      subtotal: 79999,
      discount: 10000,
      deliveryFee: 200,
      total: 70199,
      address: AddressModel(
        id: 'addr_1',
        fullName: 'Rakib Akram',
        phone: '+8801700000000',
        address: 'House 42, Road 11, Banani',
        city: 'Dhaka',
        area: 'Banani',
        postalCode: '1213',
        addressType: 'Home',
        isDefault: true,
      ),
      paymentMethod: 'Credit Card',
      orderStatus: 'Processing',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      estimatedDelivery: DateTime.now().add(const Duration(days: 2)),
    ),
  ]);

  void addOrder(OrderModel order) {
    state = [order, ...state];
  }

  void updateOrderStatus(String orderId, String newStatus) {
    state = state.map((order) {
      if (order.id == orderId) {
        return OrderModel(
          id: order.id,
          userId: order.userId,
          items: order.items,
          subtotal: order.subtotal,
          discount: order.discount,
          deliveryFee: order.deliveryFee,
          total: order.total,
          address: order.address,
          paymentMethod: order.paymentMethod,
          orderStatus: newStatus,
          createdAt: order.createdAt,
          estimatedDelivery: order.estimatedDelivery,
        );
      }
      return order;
    }).toList();
  }
}
