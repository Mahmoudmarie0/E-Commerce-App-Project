import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceproject/screens/admin/categories/model.dart';

class ProductModel {
  String id;
  String name;
  double price;
  int quantity;
  CategoryModel category;
  String image;
  DateTime createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.category,
    required this.image,
    required this.createdAt,
  });


  factory ProductModel.fromDocument(Map<String, dynamic> data, String documentId) {
    return ProductModel(
      id: documentId,
      name: data['name'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      quantity: data['quantity'] ?? 0,
      category: CategoryModel(
        id: data['category_id'] ?? '',
        name: data['category_name'] ?? '',
        createdAt: DateTime.now(),
      ),
      image: data['image'] ?? '',
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'category_id': category.id,
      'category_name': category.name,
      'image': image,
      'created_at': FieldValue.serverTimestamp(),
    };
  }
}