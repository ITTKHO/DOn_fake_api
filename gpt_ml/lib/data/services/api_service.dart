// FILE: lib/data/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ApiService {
  static const _host = 'fakestoreapi.com';

  /// Fetch a list of products. If [category] provided, fetch only that category.
  /// Uses Uri.https to safely encode categories with special characters.
  Future<List<Product>> fetchProducts({String? category}) async {
    late final Uri uri;
    if (category == null || category.isEmpty) {
      uri = Uri.https(_host, '/products');
    } else {
      // ensure category path segment is encoded
      final encoded = Uri.encodeComponent(category);
      uri = Uri.https(_host, '/products/category/$encoded');
    }
    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Failed to load products (${res.statusCode})');
    }
    final list = jsonDecode(res.body) as List;
    return list.map((e) => Product.fromJson((e as Map).cast<String, dynamic>())).toList();
    }

  Future<Product> fetchProduct(int id) async {
    final uri = Uri.https(_host, '/products/$id');
    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Failed to load product ($id)');
    }
    final map = jsonDecode(res.body) as Map<String, dynamic>;
    return Product.fromJson(map);
  }
}
