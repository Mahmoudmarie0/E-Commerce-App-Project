import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceproject/models/categories-model.dart';
import 'storage-service.dart';

class DbService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // **Categories**

  /// Stream to read categories ordered by priority
  Stream<List<Category>> readCategories() {
    return _firestore
        .collection("shop_categories")
        .orderBy("priority", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Category.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  /// Fetch categories once
  Future<List<Category>> getCategories() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("shop_categories")
          .orderBy("priority", descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Category.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }

  /// Add a new category with a random 2-digit ID
  Future<void> addCategory(Category category) async {
    try {
      String randomId = _generateRandomId();

      await _firestore.collection('shop_categories').doc(randomId).set({
        'id': randomId,
        ...category.toMap(),
      });
      print("Category '${category.name}' added successfully with ID '$randomId'.");
    } catch (e) {
      print("Error adding category: $e");
    }
  }

  /// Generate a random 2-digit number as a string
  String _generateRandomId() {
    final random = Random();
    return (random.nextInt(90) + 10).toString();
  }

  /// Create a new category using a Map of data
  Future<void> createCategory({required Map<String, dynamic> data}) async {
    try {
      await _firestore.collection("shop_categories").add(data);
      print("Category created successfully with data: $data");
    } catch (e) {
      print("Error creating category: $e");
    }
  }

  /// Update an existing category
  Future<void> updateCategory({
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection("shop_categories").doc(docId).update(data);
      print("Category with ID '$docId' updated successfully.");
    } catch (e) {
      print("Error updating category: $e");
    }
  }

  /// Delete a category and its associated products
  Future<void> deleteCategory({required String docId, String? imagePath}) async {
    try {
      // Delete associated products
      await deleteProductsByCategoryId(docId);

      // Delete the category
      await _firestore.collection("shop_categories").doc(docId).delete();
      print("Category with ID '$docId' deleted successfully.");

      // Delete the associated image from Firebase if imagePath is provided
      if (imagePath != null) {
        await StorageService().deleteImage(imagePath);
      }
    } catch (e) {
      print("Error deleting category: $e");
    }
  }

  /// Delete products by category ID
  Future<void> deleteProductsByCategoryId(String categoryId) async {
    try {
      QuerySnapshot productsSnapshot = await _firestore
          .collection("shop_products")
          .where("category", isEqualTo: categoryId)
          .get();

      for (var productDoc in productsSnapshot.docs) {
        await productDoc.reference.delete();
        print("Deleted product with ID: ${productDoc.id}");
      }
    } catch (e) {
      print("Error deleting products by category ID: $e");
    }
  }

  // **Products**

  /// Stream to read products ordered by category
  Stream<QuerySnapshot> readProducts() {
    return _firestore
        .collection("shop_products")
        .orderBy("category", descending: true)
        .snapshots();
  }

  /// Create a new product using a Map of data
  Future<void> createProduct({required Map<String, dynamic> data}) async {
    try {
      await _firestore.collection("shop_products").add(data);
      print("Product created successfully with data: $data");
    } catch (e) {
      print("Error creating product: $e");
    }
  }

  /// Update an existing product
  Future<void> updateProduct({
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection("shop_products").doc(docId).update(data);
      print("Product with ID '$docId' updated successfully.");
    } catch (e) {
      print("Error updating product: $e");
    }
  }

  /// Delete a product
  Future<void> deleteProduct({required String docId}) async {
    try {
      await _firestore.collection("shop_products").doc(docId).delete();
      print("Product with ID '$docId' deleted successfully.");
    } catch (e) {
      print("Error deleting product: $e");
    }
  }
}
