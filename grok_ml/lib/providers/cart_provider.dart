// FILE: lib/providers/cart_provider.dart
import 'package:flutter/foundation.dart';
import 'package:bakery_app/data/models/cart_item.dart'; // Adjust import
import 'package:bakery_app/data/models/product.dart'; // Adjust import

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  List<CartItem> get items => _items;

  double get total {
    return _items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);
  }

  void add(Product product) {
    final existing = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );
    if (existing.quantity > 0) {
      existing.quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void remove(int id) {
    _items.removeWhere((item) => item.product.id == id);
    notifyListeners();
  }

  void updateQuantity(int id, int quantity) {
    final item = _items.firstWhere((item) => item.product.id == id);
    item.quantity = quantity;
    if (item.quantity <= 0) {
      remove(id);
    }
    notifyListeners();
  }
}