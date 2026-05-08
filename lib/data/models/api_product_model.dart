import '../../domain/entities/api_product.dart';

class ApiProductModel extends ApiProduct {
  const ApiProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
    required super.ratingCount,
  });

  factory ApiProductModel.fromJson(Map<String, dynamic> json) {
    final ratingData = json['rating'];
    return ApiProductModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      image: json['image'] as String? ?? '',
      rating: ratingData is Map
          ? (ratingData['rate'] as num?)?.toDouble() ?? 0.0
          : 0.0,
      ratingCount:
          ratingData is Map ? (ratingData['count'] as int?) ?? 0 : 0,
    );
  }

  factory ApiProductModel.fromEntity(ApiProduct entity) => ApiProductModel(
        id: entity.id,
        title: entity.title,
        price: entity.price,
        description: entity.description,
        category: entity.category,
        image: entity.image,
        rating: entity.rating,
        ratingCount: entity.ratingCount,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': {'rate': rating, 'count': ratingCount},
      };
}
