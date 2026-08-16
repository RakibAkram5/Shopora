import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopora/shared/models/product_model.dart';
import 'package:shopora/features/home/data/sample_data.dart';

final wishlistControllerProvider =
    StateNotifierProvider<WishlistController, List<ProductModel>>((ref) {
  return WishlistController();
});

class WishlistController extends StateNotifier<List<ProductModel>> {
  WishlistController() : super([SampleData.products.first]);

  bool isWishlisted(String productId) {
    return state.any((product) => product.id == productId);
  }

  void toggleWishlist(ProductModel product) {
    if (isWishlisted(product.id)) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }

  void removeProduct(String productId) {
    state = state.where((p) => p.id != productId).toList();
  }
}
