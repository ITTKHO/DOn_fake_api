// FILE: lib/providers/product_provider.dart
import 'package:flutter/foundation.dart';
import 'package:bakery_app/data/models/product.dart'; // Adjust import
import 'package:bakery_app/data/services/api_service.dart'; // Adjust import

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  Future<void> loadProducts({String? category}) async {
    _products = await ApiService.fetchProducts(category: category);
    notifyListeners();
  }

  List<Product> search(String query) {
    if (query.isEmpty) return _products;
    return _products.where((p) =>
        p.title.toLowerCase().contains(query.toLowerCase()) ||
        p.description.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}