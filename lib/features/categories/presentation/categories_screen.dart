import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopora/core/constants/app_constants.dart';
import 'package:shopora/features/home/data/sample_data.dart';
import 'package:shopora/features/products/presentation/product_details_screen.dart';
import 'package:shopora/shared/widgets/product_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopora/features/wishlist/presentation/wishlist_controller.dart';
import 'package:shopora/features/cart/presentation/cart_controller.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  String selectedCategoryId = 'cat_1';

  @override
  Widget build(BuildContext context) {
    final categories = SampleData.categories;
    final products = SampleData.products;
    final filteredProducts =
        products.where((p) => p.categoryId == selectedCategoryId).toList();
    final wishlist = ref.watch(wishlistControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Row(
        children: [
          // Category Sidebar
          Container(
            width: 100,
            color: AppColors.surface,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category.id == selectedCategoryId;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryId = category.id;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.transparent,
                      border: Border(
                        left: BorderSide(
                          color: isSelected ? AppColors.primary : Colors.transparent,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: category.image,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Product Grid
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text(
                      'No products found in this category',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      final isWishlisted =
                          wishlist.any((w) => w.id == product.id);

                      return ProductCard(
                        product: product,
                        isWishlisted: isWishlisted,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailsScreen(product: product),
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
                              content: Text('Added to cart successfully!'),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
