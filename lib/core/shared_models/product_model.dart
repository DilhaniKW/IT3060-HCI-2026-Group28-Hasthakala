class ProductModel {
  final String id;
  final String artisanId;
  final String artisanName;
  final String title;
  final String description;
  final double priceLkr;
  final String category; // Pottery, Batik, Wood Carving, Brassware, Mask, Cane/Bamboo
  final List<String> imageUrls;
  final int stockQuantity;
  final String district; // Origin district (e.g. Kegalle, Kandy, Ambalangoda)
  final double rating;
  final int reviewCount;
  final bool isAvailable;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.artisanId,
    required this.artisanName,
    required this.title,
    required this.description,
    required this.priceLkr,
    required this.category,
    required this.imageUrls,
    this.stockQuantity = 1,
    required this.district,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isAvailable = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'artisanId': artisanId,
      'artisanName': artisanName,
      'title': title,
      'description': description,
      'priceLkr': priceLkr,
      'category': category,
      'imageUrls': imageUrls,
      'stockQuantity': stockQuantity,
      'district': district,
      'rating': rating,
      'reviewCount': reviewCount,
      'isAvailable': isAvailable,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map, String docId) {
    return ProductModel(
      id: docId,
      artisanId: map['artisanId'] ?? '',
      artisanName: map['artisanName'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      priceLkr: (map['priceLkr'] as num?)?.toDouble() ?? 0.0,
      category: map['category'] ?? 'General',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      stockQuantity: (map['stockQuantity'] as num?)?.toInt() ?? 1,
      district: map['district'] ?? 'Sri Lanka',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (map['reviewCount'] as num?)?.toInt() ?? 0,
      isAvailable: map['isAvailable'] ?? true,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
