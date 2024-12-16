import 'package:ecommerceproject/screens/admin/categories/model.dart';
import 'package:ecommerceproject/screens/admin/products/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../global_controllers/text-field.dart';

class AdminController extends GetxController
{

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController categoryEditController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productImageController = TextEditingController();
  List <CategoryModel> categories = [];
  List <ProductModel> products = [];
  CategoryModel? selectedCategory;
  bool categoriesLoader = false;
  bool productsLoader = false;

  @override
  void onReady() {
    // TODO: implement onInit
    getAllCategories();
    getAllProducts();
  }


  //*************** Category Dialogs for creating and editing the categories ***************
  void openAddCategoryDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures the dialog takes minimal space
            children: [
              // Title
              const Text(
                'Add Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),

              // Custom TextField
              BuildTextField(
                hintText: 'Enter category name',
                controller: categoryNameController,
              ),
              SizedBox(height: 16.0),

              // Add Category Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    addCategoryToDatabase(categoryNameController.text);
                    categories = [];
                    getAllCategories();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Change to your preferred color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Add Category',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void openEditCategoryDialog(CategoryModel category) {
    categoryEditController.text = category.name;
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: const Text(
          "Edit Category",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BuildTextField(
              hintText: "Category Name",
              controller: categoryEditController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateCategoryInDatabase(category.id , categoryEditController.text);
                categories = [];
                getAllCategories();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "Update",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }
  //*************** Category Dialogs for creating and editing the categories ***************



  //*************** Functions to handle the CRUD operations for categories in the firestore ***************
  Future<void> addCategoryToDatabase(String categoryName) async {
    try {
      if (categoryName.trim().isEmpty) {
        Get.snackbar("Error", "Category name cannot be empty");
        return;
      }
      await FirebaseFirestore.instance
          .collection('shop_categories')
          .add({
        'name': categoryName,
        'created_at': FieldValue.serverTimestamp(),
      });
      Get.snackbar("Success", "Category added successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to add category: $e");
    }
  }
  Future<void> getAllCategories() async {
    try {
      // Start loading
      categoriesLoader = true;
      update(); // Notify listeners to rebuild the UI with the loader

      CollectionReference categoriesRef =
      FirebaseFirestore.instance.collection('shop_categories');
      QuerySnapshot querySnapshot = await categoriesRef.get();

      categories.clear();

      for (var doc in querySnapshot.docs) {
        String categoryId = doc.id;
        String categoryName = doc['name'] ?? '';
        DateTime createdAt = (doc['created_at'] as Timestamp).toDate();

        categories.add(CategoryModel(
          id: categoryId,
          name: categoryName,
          createdAt: createdAt,
        ));
      }

      print("Categories fetched successfully: $categories");
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      // Stop loading
      categoriesLoader = false;
      update(); // Notify listeners to rebuild the UI without the loader
    }
  }
  Future<void> updateCategoryInDatabase(String categoryId, String updatedCategoryName) async {
    try {
      if (updatedCategoryName.trim().isEmpty) {
        Get.snackbar("Error", "Category name cannot be empty");
        return;
      }

      await FirebaseFirestore.instance
          .collection('shop_categories')
          .doc(categoryId)
          .update({
        'name': updatedCategoryName,
        'updated_at': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Category updated successfully!");
      update();
    } catch (e) {
      Get.snackbar("Error", "Failed to update category: $e");
    }
  }
  Future<void> deleteCategoryById(CategoryModel category) async {
    try {
      CollectionReference categoriesRef =
      FirebaseFirestore.instance.collection('shop_categories');


      await categoriesRef.doc(category.id).delete();

      print("Category '${category.name}' deleted successfully.");
      categories = [];
      getAllCategories();
      update();
    } catch (e) {
      print("Error deleting category: $e");
    }
  }
  //*************** Functions to handle the CRUD operations for categories in the firestore ***************



  //*************** Products Dialogs for creating and editing the Products ***************
  void openAddProductDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Product',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),

              // Product Name TextField
              BuildTextField(
                hintText: 'Enter product name',
                controller: productNameController,
              ),
              SizedBox(height: 16.0),

              // Price TextField
              BuildTextField(
                hintText: 'Enter product price',
                controller: productPriceController,
                inputType: TextInputType.number,
              ),
              SizedBox(height: 16.0),

              // Quantity TextField
              BuildTextField(
                hintText: 'Enter product quantity',
                controller: productQuantityController,
                inputType: TextInputType.number,
              ),
              SizedBox(height: 16.0),

              // Dropdown for categories
              DropdownButton<CategoryModel>(
                value: selectedCategory,
                hint: const Text('Select Category'),
                onChanged: (CategoryModel? newValue) {
                  selectedCategory = newValue;
                  update();
                },
                items: categories.map((CategoryModel category) {
                  return DropdownMenuItem<CategoryModel>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),

              // Image URL TextField
              BuildTextField(
                hintText: 'Enter image URL',
                controller: productImageController,
              ),
              SizedBox(height: 16.0),

              // Add Product Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedCategory != null) {
                      addProductToDatabase();
                      productNameController.clear();
                      productPriceController.clear();
                      productQuantityController.clear();
                      productImageController.clear();
                      selectedCategory = null;
                      Get.back();
                    } else {
                      Get.snackbar("Error", "Please select a category");
                    }
                    products = [];
                    getAllProducts();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Add Product',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void openEditProductDialog(ProductModel product) {
    categoryEditController.text = product.name;
    TextEditingController priceController = TextEditingController(text: product.price.toString());
    TextEditingController quantityController = TextEditingController(text: product.quantity.toString());
    TextEditingController imageLinkController = TextEditingController(text: product.image);

    Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: const Text(
            "Edit Product",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BuildTextField(
                  hintText: "Product Name",
                  controller: categoryEditController,
                ),
                const SizedBox(height: 10),

                BuildTextField(
                  hintText: "Price",
                  controller: priceController,
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 10),

                // Quantity
                BuildTextField(
                  hintText: "Quantity",
                  controller: quantityController,
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 10),


                DropdownButtonFormField<CategoryModel>(
                  value: product.category,
                  items: categories.map((CategoryModel category) {
                    return DropdownMenuItem<CategoryModel>(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (newCategory) {

                    if (newCategory != null) {
                      product.category = newCategory;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: "Select Category",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),


                BuildTextField(
                  hintText: "Image Link",
                  controller: imageLinkController,
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    updateProductInDatabase(
                      product.id,
                      ProductModel(
                        id: product.id,
                        name: categoryEditController.text,
                        price: double.tryParse(priceController.text) ?? 0,
                        quantity: int.tryParse(quantityController.text) ?? 0,
                        category: product.category, // Updated category
                        image: imageLinkController.text,
                        createdAt: DateTime.now(),
                      ),
                    );
                    products = [];
                    getAllProducts();
                    update();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
          barrierDismissible: true,
        );
    }
//*************** Products Dialogs for creating and editing the Products ***************



//*************** Functions to handle the CRUD operations for Products in the firestore ***************
  Future<void> addProductToDatabase() async {
    try {
      // Get values from the text fields
      String productName = productNameController.text;
      double productPrice = double.tryParse(productPriceController.text) ?? 0.0;
      int productQuantity = int.tryParse(productQuantityController.text) ?? 0;
      String productImage = productImageController.text;

      // Validate input
      if (productName.isEmpty || productPrice <= 0 || productQuantity <= 0 || productImage.isEmpty) {
        Get.snackbar("Error", "Please fill in all fields correctly");
        return;
      }

      // Create ProductModel instance
      ProductModel newProduct = ProductModel(
        id: '',
        name: productName,
        price: productPrice,
        quantity: productQuantity,
        category: selectedCategory!,
        image: productImage,
        createdAt: DateTime.now(),
      );


      await FirebaseFirestore.instance.collection('products').add(newProduct.toMap());
      Get.snackbar("Success", "Product added successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to add product: $e");
    }
  }
  Future<void> getAllProducts() async {
    try {
      // Start loading
      productsLoader = true;
      update(); // Notify listeners to rebuild the UI with the loader

      await getAllCategories(); // Ensure categories are loaded first

      CollectionReference productsRef = FirebaseFirestore.instance.collection('products');
      QuerySnapshot querySnapshot = await productsRef.get();

      products.clear();

      for (var doc in querySnapshot.docs) {
        String productId = doc.id;
        String productName = doc['name'] ?? '';
        double productPrice = (doc['price'] ?? 0.0).toDouble();
        int productQuantity = (doc['quantity'] ?? 0);
        String imageUrl = doc['image'] ?? '';
        DateTime createdAt = (doc['created_at'] as Timestamp).toDate();

        String categoryId = doc['category_id'] ?? '';
        CategoryModel? productCategory;

        if (categoryId.isNotEmpty) {
          productCategory = categories.firstWhere(
                  (category) => category.id == categoryId,
              orElse: () => CategoryModel(id: categoryId, name: 'Unknown', createdAt: DateTime.now()));
        }

        products.add(ProductModel(
          id: productId,
          name: productName,
          price: productPrice,
          quantity: productQuantity,
          category: productCategory!,
          image: imageUrl,
          createdAt: createdAt,
        ));
      }

      print("Products fetched successfully: $products");
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      // Stop loading
      productsLoader = false;
      update(); // Notify listeners to rebuild the UI without the loader
    }
  }
  Future<void> updateProductInDatabase(String productId, ProductModel updatedProduct) async {
    try {
      if (updatedProduct.name.trim().isEmpty) {
        Get.snackbar("Error", "Product name cannot be empty");
        return;
      }

      // Fetch the category name based on the category ID
      String categoryName = '';
      if (updatedProduct.category.id.isNotEmpty) {
        DocumentSnapshot categoryDoc = await FirebaseFirestore.instance
            .collection('shop_categories')
            .doc(updatedProduct.category.id)
            .get();

        if (categoryDoc.exists) {
          categoryName = categoryDoc['name'] ?? ''; // Retrieve the category name
        }
      }

      // Update the product document with the new values
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .update({
        'name': updatedProduct.name,
        'price': updatedProduct.price,
        'quantity': updatedProduct.quantity,
        'category': updatedProduct.category.id, // Keep the category ID
        'category_name': categoryName, // Add the category name
        'image': updatedProduct.image,
        'updated_at': FieldValue.serverTimestamp(),
      });

      // Update the local product list
      final index = products.indexWhere((product) => product.id == productId);
      if (index != -1) {
        products[index] = updatedProduct; // Update the existing product in the list
        products[index].category.name = categoryName; // Ensure the category name is updated
      }

      Get.snackbar("Success", "Product updated successfully!");
      update(); // Notify listeners to update the UI
    } catch (e) {
      Get.snackbar("Error", "Failed to update product: $e");
    }
  }
  Future<void> deleteProductById(ProductModel product) async {
    try {
      CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

      // Check if the document exists before trying to delete it
      DocumentSnapshot productDoc = await productsRef.doc(product.id).get();
      if (!productDoc.exists) {
        Get.snackbar("Error", "Product does not exist.");
        return;
      }

      // Delete the document
      await productsRef.doc(product.id).delete();

      print("Product '${product.name}' deleted successfully.");
      products = []; // Clear the product list (optional)
      await getAllProducts(); // Fetch updated product list
      update(); // Notify listeners to update the UI
      Get.snackbar("Success", "Product deleted successfully!"); // Show success message
    } catch (e) {
      print("Error deleting product: $e");
      Get.snackbar("Error", "Failed to delete product: $e"); // Show error message
    }
  }
//*************** Functions to handle the CRUD operations for Products in the firestore ***************



}

