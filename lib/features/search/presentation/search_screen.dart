import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopora/core/constants/app_constants.dart';
import 'package:shopora/features/home/data/sample_data.dart';
import 'package:shopora/features/products/presentation/product_details_screen.dart';
import 'package:shopora/shared/widgets/product_card.dart';
import 'package:shopora/features/wishlist/presentation/wishlist_controller.dart';
import 'package:shopora/features/cart/presentation/cart_controller.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final products = SampleData.products;
    final wishlist = ref.watch(wishlistControllerProvider);
    final searchResults = _searchQuery.isEmpty
        ? []
        : products
            .where((p) =>
                p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                p.brand.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                p.description.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: (val) {
            setState(() {
              _searchQuery = val;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search products, brands...',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
          ),
        ),
        actions: [
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() => _searchQuery = '');
              },
            ),
        ],
      ),
      body: _searchQuery.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Searches',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: ['AirPods', 'Nike Shoes', 'Smart Watch', 'Leather Jacket']
                        .map((term) => ActionChip(
                              label: Text(term),
                              onPressed: () {
                                _searchController.text = term;
                                setState(() => _searchQuery = term);
                              },
                            ))
                        .toList(),
                  ),
                ],
              ),
            )
          : searchResults.isEmpty
              ? const Center(
                  child: Text(
                    'No products found matching your search.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.68,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final product = searchResults[index];
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
                            content: Text('Added to cart!'),
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
