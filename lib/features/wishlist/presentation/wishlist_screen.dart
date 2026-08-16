import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopora/core/constants/app_constants.dart';
import 'package:shopora/features/wishlist/presentation/wishlist_controller.dart';
import 'package:shopora/features/cart/presentation/cart_controller.dart';
import 'package:shopora/features/products/presentation/product_details_screen.dart';
import 'package:shopora/shared/widgets/empty_state_widget.dart';
import 'package:shopora/shared/widgets/product_card.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Wishlist')),
      body: wishlist.isEmpty
          ? EmptyStateWidget(
              title: 'Your wishlist is empty',
              message: 'Save items you love to your wishlist and shop them anytime.',
              buttonText: 'Explore Products',
              icon: Icons.favorite_border,
              onButtonPressed: () {
                // Navigate back or to home
              },
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlist[index];
                return ProductCard(
                  product: product,
                  isWishlisted: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                  onWishlistTap: () {
                    ref
                        .read(wishlistControllerProvider.notifier)
                        .toggleWishlist(product);
                  },
                  onAddToCart: () {
                    ref.read(cartControllerProvider.notifier).addToCart(
                          productId: product.id,
                          productName: product.name,
                          productImage: product.images.first,
                          price: product.price,
                          discountPrice: product.discountPrice,
                          selectedSize: product.sizes.first,
                          selectedColor: product.colors.first,
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Moved to cart!'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
