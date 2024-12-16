import 'dart:convert';

import 'package:get/get.dart';
import 'package:ecommerceproject/models/products-model.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import your Product model

class ProductController extends GetxController {
  // Observable list of products
  var products = <Product>[].obs;

  // Load products from SharedPreferences
  Future<void> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> productJsonList = prefs.getStringList('products') ?? [];
    products.value = productJsonList
        .map((jsonString) => Product.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  // Save products to SharedPreferences
  Future<void> saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> productJsonList =
    products.map((product) => jsonEncode(product.toJson())).toList();
    await prefs.setStringList('products', productJsonList);
  }

  // Add product to the list
  void addProduct(Product product) {
    products.add(product);
    saveProducts();
  }

  // Remove product from the list
  void removeProduct(Product product) {
    products.remove(product);
    saveProducts();
  }
}
