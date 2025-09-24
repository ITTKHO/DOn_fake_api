// FILE: lib/data/models/product.dart
class ProductRating {
  final double rate;
  final int count;

  const ProductRating({required this.rate, required this.count});

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );
  }
}

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  final ProductRating rating;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] as String? ?? '',
      category: json['category'] as String? ?? '',
      rating: ProductRating.fromJson((json['rating'] as Map?)?.cast<String, dynamic>() ?? const {}),
    );
  }
}
