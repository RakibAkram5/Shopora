class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double subtotal;
  final double discount;
  final double deliveryFee;
  final double total;
  final AddressModel address;
  final String paymentMethod;
  final String orderStatus; // Pending, Confirmed, Processing, Shipped, Delivered, Cancelled
  final DateTime createdAt;
  final DateTime? estimatedDelivery;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.deliveryFee,
    required this.total,
    required this.address,
    required this.paymentMethod,
    required this.orderStatus,
    required this.createdAt,
    this.estimatedDelivery,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((x) => x.toMap()).toList(),
      'subtotal': subtotal,
      'discount': discount,
      'deliveryFee': deliveryFee,
      'total': total,
      'address': address.toMap(),
      'paymentMethod': paymentMethod,
      'orderStatus': orderStatus,
      'createdAt': createdAt.toIso8601String(),
      'estimatedDelivery': estimatedDelivery?.toIso8601String(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map, String id) {
    return OrderModel(
      id: id,
      userId: map['userId'] ?? '',
      items: List<OrderItem>.from(
          (map['items'] ?? []).map((x) => OrderItem.fromMap(x))),
      subtotal: (map['subtotal'] ?? 0.0).toDouble(),
      discount: (map['discount'] ?? 0.0).toDouble(),
      deliveryFee: (map['deliveryFee'] ?? 0.0).toDouble(),
      total: (map['total'] ?? 0.0).toDouble(),
      address: AddressModel.fromMap(map['address'] ?? {}),
      paymentMethod: map['paymentMethod'] ?? '',
      orderStatus: map['orderStatus'] ?? 'Pending',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      estimatedDelivery: map['estimatedDelivery'] != null
          ? DateTime.parse(map['estimatedDelivery'])
          : null,
    );
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final String size;
  final String color;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.size,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      productImage: map['productImage'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      quantity: map['quantity'] ?? 1,
      size: map['size'] ?? '',
      color: map['color'] ?? '',
    );
  }
}
