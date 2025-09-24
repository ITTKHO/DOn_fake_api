// FILE: lib/providers/cart_provider.dart
import 'package:flutter/foundation.dart';
import '../data/models/product.dart';
import '../data/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList(growable: false);
  int get totalItems => _items.values.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice =>
      _items.values.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));

  void add(Product product) {
    final existing = _items[product.id];
    if (existing != null) {
      existing.quantity += 1;
    } else {
      _items[product.id] = CartItem(product: product, quantity: 1);
    }
    notifyListeners();
  }

  void remove(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void increment(int productId) {
    final item = _items[productId];
    if (item != null) {
      item.quantity += 1;
      notifyListeners();
    }
  }

  void decrement(int productId) {
    final item = _items[productId];
    if (item != null) {
      if (item.quantity > 1) {
        item.quantity -= 1;
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
