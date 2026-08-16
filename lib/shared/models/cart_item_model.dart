class CartItemModel {
  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final double? discountPrice;
  final String selectedSize;
  final String selectedColor;
  int quantity;
  bool isSelected;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    this.discountPrice,
    required this.selectedSize,
    required this.selectedColor,
    required this.quantity,
    this.isSelected = true,
  });

  double get effectivePrice => discountPrice ?? price;
  double get totalPrice => effectivePrice * quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'discountPrice': discountPrice,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'quantity': quantity,
      'isSelected': isSelected,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map, String id) {
    return CartItemModel(
      id: id,
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      productImage: map['productImage'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      discountPrice: map['discountPrice'] != null ? (map['discountPrice']).toDouble() : null,
      selectedSize: map['selectedSize'] ?? '',
      selectedColor: map['selectedColor'] ?? '',
      quantity: map['quantity'] ?? 1,
      isSelected: map['isSelected'] ?? true,
    );
  }
}
