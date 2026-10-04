enum OrderStatus {
  pending,
  confirmed,
  crafting,
  dispatched,
  delivered,
  cancelled,
}

class OrderItemModel {
  final String productId;
  final String title;
  final double unitPriceLkr;
  final int quantity;
  final String? imageUrl;
  final String artisanId;

  OrderItemModel({
    required this.productId,
    required this.title,
    required this.unitPriceLkr,
    required this.quantity,
    this.imageUrl,
    required this.artisanId,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'unitPriceLkr': unitPriceLkr,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'artisanId': artisanId,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      productId: map['productId'] ?? '',
      title: map['title'] ?? '',
      unitPriceLkr: (map['unitPriceLkr'] as num?)?.toDouble() ?? 0.0,
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      imageUrl: map['imageUrl'],
      artisanId: map['artisanId'] ?? '',
    );
  }
}

class OrderModel {
  final String id;
  final String buyerId;
  final String buyerName;
  final List<OrderItemModel> items;
  final double totalAmountLkr;
  final String shippingAddress;
  final String contactPhone;
  final OrderStatus status;
  final String paymentMethod; // COD, Card, Bank Transfer
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.buyerId,
    required this.buyerName,
    required this.items,
    required this.totalAmountLkr,
    required this.shippingAddress,
    required this.contactPhone,
    this.status = OrderStatus.pending,
    required this.paymentMethod,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buyerId': buyerId,
      'buyerName': buyerName,
      'items': items.map((x) => x.toMap()).toList(),
      'totalAmountLkr': totalAmountLkr,
      'shippingAddress': shippingAddress,
      'contactPhone': contactPhone,
      'status': status.name,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map, String docId) {
    return OrderModel(
      id: docId,
      buyerId: map['buyerId'] ?? '',
      buyerName: map['buyerName'] ?? '',
      items: (map['items'] as List<dynamic>?)
              ?.map((item) => OrderItemModel.fromMap(Map<String, dynamic>.from(item)))
              .toList() ??
          [],
      totalAmountLkr: (map['totalAmountLkr'] as num?)?.toDouble() ?? 0.0,
      shippingAddress: map['shippingAddress'] ?? '',
      contactPhone: map['contactPhone'] ?? '',
      status: OrderStatus.values.firstWhere(
        (s) => s.name == map['status'],
        orElse: () => OrderStatus.pending,
      ),
      paymentMethod: map['paymentMethod'] ?? 'COD',
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
