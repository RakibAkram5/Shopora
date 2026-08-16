import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopora/core/constants/app_constants.dart';
import 'package:shopora/shared/models/product_model.dart';
import 'package:shopora/shared/widgets/app_button.dart';
import 'package:shopora/shared/widgets/price_widget.dart';
import 'package:shopora/shared/widgets/rating_widget.dart';
import 'package:shopora/shared/widgets/product_image_carousel.dart';
import 'package:shopora/features/cart/presentation/cart_controller.dart';
import 'package:shopora/features/wishlist/presentation/wishlist_controller.dart';
import 'package:shopora/features/checkout/presentation/checkout_screen.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  late String selectedSize;
  late String selectedColor;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.product.sizes.isNotEmpty ? widget.product.sizes.first : 'Standard';
    selectedColor = widget.product.colors.isNotEmpty ? widget.product.colors.first : 'Default';
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = ref.watch(wishlistControllerProvider);
    final isWishlisted = wishlist.any((w) => w.id == widget.product.id);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                isWishlisted ? Icons.favorite : Icons.favorite_border,
                color: isWishlisted ? AppColors.accent : AppColors.textPrimary,
              ),
              onPressed: () {
                ref
                    .read(wishlistControllerProvider.notifier)
                    .toggleWishlist(widget.product);
              },
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageCarousel(images: widget.product.images),
            Container(
              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.between,
                    children: [
                      Text(
                        widget.product.brand.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      RatingWidget(
                        rating: widget.product.rating,
                        reviewCount: widget.product.reviewCount,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  PriceWidget(
                    price: widget.product.price,
                    discountPrice: widget.product.discountPrice,
                    fontSize: 20,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (widget.product.sizes.isNotEmpty) ...[
                    const Text(
                      'Select Size',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      children: widget.product.sizes.map((size) {
                        final isSelected = size == selectedSize;
                        return ChoiceChip(
                          label: Text(size),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          onSelected: (_) {
                            setState(() => selectedSize = size);
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (widget.product.colors.isNotEmpty) ...[
                    const Text(
                      'Select Color',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      children: widget.product.colors.map((color) {
                        final isSelected = color == selectedColor;
                        return ChoiceChip(
                          label: Text(color),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          onSelected: (_) {
                            setState(() => selectedColor = color);
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            ref.read(cartControllerProvider.notifier).addToCart(
                                  productId: widget.product.id,
                                  productName: widget.product.name,
                                  productImage: widget.product.images.first,
                                  price: widget.product.price,
                                  discountPrice: widget.product.discountPrice,
                                  selectedSize: selectedSize,
                                  selectedColor: selectedColor,
                                  quantity: quantity,
                                );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to Cart!'),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primary, width: 2),
                            minimumSize: const Size(double.infinity, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppButton(
                          text: 'Buy Now',
                          onPressed: () {
                            ref.read(cartControllerProvider.notifier).addToCart(
                                  productId: widget.product.id,
                                  productName: widget.product.name,
                                  productImage: widget.product.images.first,
                                  price: widget.product.price,
                                  discountPrice: widget.product.discountPrice,
                                  selectedSize: selectedSize,
                                  selectedColor: selectedColor,
                                  quantity: quantity,
                                );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CheckoutScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
