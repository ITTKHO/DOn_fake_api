// FILE: lib/data/models/cart_item.dart
import 'package:bakery_app/data/models/product.dart'; // Adjust import based on app name

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}