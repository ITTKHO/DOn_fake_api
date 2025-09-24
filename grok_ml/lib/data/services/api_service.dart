// FILE: lib/data/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bakery_app/data/models/product.dart'; // Adjust import based on app name

class ApiService {
  static const _host = 'fakestoreapi.com';

  static Future<List<Product>> fetchProducts({String? category}) async {
    final path = category != null ? '/products/category/$category' : '/products';
    final uri = Uri.https(_host, path);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<Product> fetchProduct(int id) async {
    final uri = Uri.https(_host, '/products/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }
}