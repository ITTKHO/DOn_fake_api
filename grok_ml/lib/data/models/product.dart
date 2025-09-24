// FILE: lib/data/models/product.dart
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final double ratingRate;
  final int ratingCount;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.ratingRate,
    required this.ratingCount,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      ratingRate: (json['rating']['rate'] as num).toDouble(),
      ratingCount: json['rating']['count'] as int,
      category: json['category'] as String,
    );
  }
}