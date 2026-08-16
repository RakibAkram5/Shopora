import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopora/core/constants/app_constants.dart';
import 'package:shopora/features/auth/presentation/auth_controller.dart';
import 'package:shopora/features/home/data/sample_data.dart';
import 'package:shopora/features/products/presentation/product_details_screen.dart';
import 'package:shopora/features/search/presentation/search_screen.dart';
import 'package:shopora/features/notifications/presentation/notifications_screen.dart';
import 'package:shopora/features/cart/presentation/cart_controller.dart';
import 'package:shopora/features/wishlist/presentation/wishlist_controller.dart';
import 'package:shopora/shared/widgets/product_card.dart';
import 'package:shopora/shared/widgets/category_card.dart';
import 'package:shopora/shared/widgets/section_header.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    final wishlist = ref.watch(wishlistControllerProvider);
    final cart = ref.watch(cartControllerProvider);
    final products = SampleData.products;
    final categories = SampleData.categories;
    final banners = SampleData.banners;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar / Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: CachedNetworkImageProvider(
                            user?.profileImage ??
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Good Morning,',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              user?.name ?? 'Rakib Akram',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined,
                              size: 26, color: AppColors.textPrimary),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const NotificationsScreen()),
                            );
                          },
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.accent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E0EC)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: AppColors.textSecondary),
                        SizedBox(width: 12),
                        Text(
                          'Search products...',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.tune, color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Promotional Banners
            SliverToBoxAdapter(
              child: SizedBox(
                height: 170,
                child: PageView.builder(
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    final banner = banners[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryDark],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(banner.image),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              banner.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            banner.subtitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                              minimumSize: const Size(100, 36),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text(banner.buttonText,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            // Categories
            const SliverToBoxAdapter(
              child: SectionHeader(title: 'Categories', actionText: 'See All'),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard(
                      category: category,
                      onTap: () {},
                    );
                  },
                ),
              ),
            ),

            // Flash Sale
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.between,
                  children: [
                    const Text(
                      '⚡ Flash Sale',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Ends in 03:45:12',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: products.where((p) => p.isFlashSale).length,
                  itemBuilder: (context, index) {
                    final flashProducts =
                        products.where((p) => p.isFlashSale).toList();
                    final product = flashProducts[index];
                    final isWishlisted = wishlist
                        .any((element) => element.id == product.id);

                    return Container(
                      width: 170,
                      margin: const EdgeInsets.only(right: 16),
                      child: ProductCard(
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
                                backgroundColor: AppColors.success),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

            // Best Sellers
            const SliverToBoxAdapter(
              child: SectionHeader(title: 'Best Sellers', actionText: 'See All'),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final bestProducts =
                        products.where((p) => p.isBestSeller).toList();
                    final product = bestProducts[index];
                    final isWishlisted = wishlist
                        .any((element) => element.id == product.id);

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
                              backgroundColor: AppColors.success),
                        );
                      },
                    );
                  },
                  childCount: products.where((p) => p.isBestSeller).length,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }
}
