class ProductModel {
  final String id;
  final String name;
  final String description;
  final String brand;
  final String categoryId;
  final double price;
  final double? discountPrice;
  final int stock;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final List<String> sizes;
  final List<String> colors;
  final Map<String, dynamic> specifications;
  final bool isFeatured;
  final bool isFlashSale;
  final bool isBestSeller;
  final bool isNewArrival;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.brand,
    required this.categoryId,
    required this.price,
    this.discountPrice,
    required this.stock,
    required this.images,
    required this.rating,
    required this.reviewCount,
    required this.sizes,
    required this.colors,
    required this.specifications,
    this.isFeatured = false,
    this.isFlashSale = false,
    this.isBestSeller = false,
    this.isNewArrival = false,
  });

  double get effectivePrice => discountPrice ?? price;

  int get discountPercentage {
    if (discountPrice != null && discountPrice! < price) {
      return (((price - discountPrice!) / price) * 100).round();
    }
    return 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'brand': brand,
      'categoryId': categoryId,
      'price': price,
      'discountPrice': discountPrice,
      'stock': stock,
      'images': images,
      'rating': rating,
      'reviewCount': reviewCount,
      'sizes': sizes,
      'colors': colors,
      'specifications': specifications,
      'isFeatured': isFeatured,
      'isFlashSale': isFlashSale,
      'isBestSeller': isBestSeller,
      'isNewArrival': isNewArrival,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      brand: map['brand'] ?? '',
      categoryId: map['categoryId'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      discountPrice: map['discountPrice'] != null ? (map['discountPrice']).toDouble() : null,
      stock: map['stock'] ?? 0,
      images: List<String>.from(map['images'] ?? []),
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      sizes: List<String>.from(map['sizes'] ?? []),
      colors: List<String>.from(map['colors'] ?? []),
      specifications: Map<String, dynamic>.from(map['specifications'] ?? {}),
      isFeatured: map['isFeatured'] ?? false,
      isFlashSale: map['isFlashSale'] ?? false,
      isBestSeller: map['isBestSeller'] ?? false,
      isNewArrival: map['isNewArrival'] ?? false,
    );
  }
}
