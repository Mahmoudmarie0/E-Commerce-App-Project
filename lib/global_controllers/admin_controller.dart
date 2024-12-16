// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerceproject/global_controllers/db-service.dart';
// import 'package:ecommerceproject/models/categories-model.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// class AdminController extends GetxController {
//   var categories = <Category>[].obs;
//   var isLoading = false.obs;
//
//   // Fetch categories from Firestore
//   Future<void> fetchCategories() async {
//     isLoading.value = true; // Start loading
//     try {
//       var fetchedCategories = await DbService().getCategories();
//       categories.assignAll(fetchedCategories);
//     } catch (e) {
//       print("Error fetching categories: $e");
//     } finally {
//       isLoading.value = false; // Stop loading
//     }
//   }
//   // Add new category
//   Future<void> addCategory(Category category) async {
//     try {
//       await FirebaseFirestore.instance.collection("shop_categories").add({
//         'name': category.name,
//       });
//       print("Category added successfully");
//     } catch (e) {
//       print("Error adding category: $e");
//     }
//   }
//
//
//   // Remove category
//   void removeCategory(String categoryId) {
//     categories.removeWhere((category) => category.id == categoryId);
//     DbService().deleteCategory(docId: categoryId);
//   }
//
//   // Update existing category
//   void updateCategory(String categoryId, Category updatedCategory) {
//     int index = categories.indexWhere((category) => category.id == categoryId);
//     if (index != -1) {
//       categories[index] = updatedCategory;
//       DbService().updateCategory(docId: categoryId, data: updatedCategory.toMap());
//     }
//   }
// }
