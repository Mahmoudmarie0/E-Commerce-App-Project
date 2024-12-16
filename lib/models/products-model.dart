import 'dart:convert';

class Product {
  String name;
  String imagePath;
  String category;
  double price;
  int quantity;
  int sales; // Add sales property

  Product({
    required this.name,
    required this.imagePath,
    required this.category,
    required this.price,
    required this.quantity,
    this.sales = 0, // Default sales to 0
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      imagePath: map['imagePath'] ?? '',
      category: map['category'] ?? '',
      price: double.tryParse(map['price'].toString()) ?? 0.0,
      quantity: int.tryParse(map['quantity'].toString()) ?? 0,
      sales: int.tryParse(map['sales'].toString()) ?? 0, // Parse sales
    );
  }

  factory Product.fromJson(String source) {
    final map = json.decode(source);
    return Product.fromMap(map);
  }

  String toJson() {
    return json.encode({
      'name': name,
      'imagePath': imagePath,
      'category': category,
      'price': price,
      'quantity': quantity,
      'sales': sales, // Include sales in JSON
    });
  }
}
