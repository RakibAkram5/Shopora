import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopora/shared/models/cart_item_model.dart';

final cartControllerProvider =
    StateNotifierProvider<CartController, List<CartItemModel>>((ref) {
  return CartController();
});

class CartController extends StateNotifier<List<CartItemModel>> {
  CartController() : super([
    CartItemModel(
      id: 'cart_1',
      productId: 'prod_1',
      productName: 'AirPods Pro 2',
      productImage: 'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=600',
      price: 79999,
      discountPrice: 69999,
      selectedSize: 'Standard',
      selectedColor: 'White',
      quantity: 1,
      isSelected: true,
    ),
  ]);

  void addToCart({
    required String productId,
    required String productName,
    required String productImage,
    required double price,
    double? discountPrice,
    required String selectedSize,
    required String selectedColor,
    int quantity = 1,
  }) {
    final existingIndex = state.indexWhere((item) =>
        item.productId == productId &&
        item.selectedSize == selectedSize &&
        item.selectedColor == selectedColor);

    if (existingIndex >= 0) {
      final updated = [...state];
      updated[existingIndex].quantity += quantity;
      state = updated;
    } else {
      final newItem = CartItemModel(
        id: 'cart_${DateTime.now().millisecondsSinceEpoch}',
        productId: productId,
        productName: productName,
        productImage: productImage,
        price: price,
        discountPrice: discountPrice,
        selectedSize: selectedSize,
        selectedColor: selectedColor,
        quantity: quantity,
        isSelected: true,
      );
      state = [...state, newItem];
    }
  }

  void incrementQuantity(String id) {
    state = state.map((item) {
      if (item.id == id) {
        item.quantity += 1;
      }
      return item;
    }).toList();
  }

  void decrementQuantity(String id) {
    state = state.map((item) {
      if (item.id == id && item.quantity > 1) {
        item.quantity -= 1;
      }
      return item;
    }).toList();
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void toggleItemSelection(String id) {
    state = state.map((item) {
      if (item.id == id) {
        item.isSelected = !item.isSelected;
      }
      return item;
    }).toList();
  }

  void clearCart() {
    state = [];
  }

  double get subtotal {
    return state
        .where((item) => item.isSelected)
        .fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get discount {
    return state.where((item) => item.isSelected).fold(0.0, (sum, item) {
      if (item.discountPrice != null && item.discountPrice! < item.price) {
        return sum + ((item.price - item.discountPrice!) * item.quantity);
      }
      return sum;
    });
  }

  double get deliveryFee => state.any((item) => item.isSelected) ? 200.0 : 0.0;

  double get total => subtotal - discount + deliveryFee;
}
