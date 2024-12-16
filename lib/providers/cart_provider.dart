import 'package:flutter/material.dart';
import 'package:ecommerceproject/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cart = [];

  List<CartItem> get cart => _cart;

  // Add product to cart or update quantity
  void addToCart(CartItem product) {
    final existingProduct = _cart.firstWhere(
          (item) => item.name == product.name,
      orElse: () => CartItem(name: "", price: "", image: ""),
    );

    if (existingProduct.name.isNotEmpty) {
      existingProduct.quantity++;
    } else {
      _cart.add(product);
    }
    notifyListeners();
  }

  // Remove product from the cart
  void removeFromCart(CartItem product) {
    _cart.remove(product);
    notifyListeners();
  }

  // Update product quantity
  void updateCartItemQuantity(CartItem product, int quantity) {
    final cartItem = _cart.firstWhere((item) => item.name == product.name);
    cartItem.quantity = quantity;
    notifyListeners();
  }

  // Get total price
  double getOrderTotal() {
    return _cart.fold(0, (total, item) => total + (double.parse(item.price) * item.quantity));
  }
}
