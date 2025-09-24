class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final double rating;
  final int ratingCount;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.ratingCount,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> j) => Product(
    id: j['id'],
    title: j['title'],
    description: j['description'],
    price: (j['price'] as num).toDouble(),
    image: j['image'],
    rating: (j['rating']?['rate'] as num?)?.toDouble() ?? 0.0,
    ratingCount: (j['rating']?['count'] as num?)?.toInt() ?? 0,
    category: j['category'] ?? '',
  );
}
