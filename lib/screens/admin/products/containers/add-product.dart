// import 'package:ecommerceproject/global_controllers/product-controller.dart';
// import 'package:ecommerceproject/models/products-model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class AddProduct extends StatelessWidget {
//   final ProductController productController = Get.find<ProductController>();
//
//   // Text controllers for form fields
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController imagePathController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController salesController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Product')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: 'Product Name'),
//             ),
//             TextField(
//               controller: imagePathController,
//               decoration: InputDecoration(labelText: 'Image Path'),
//             ),
//             TextField(
//               controller: categoryController,
//               decoration: InputDecoration(labelText: 'Category'),
//             ),
//             TextField(
//               controller: priceController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Price'),
//             ),
//             TextField(
//               controller: quantityController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Quantity'),
//             ),
//             TextField(
//               controller: salesController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Sales'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Create a new product from the form data
//                 final newProduct = Product(
//                   name: nameController.text,
//                   imagePath: imagePathController.text,
//                   category: categoryController.text,
//                   price: double.tryParse(priceController.text) ?? 0.0,
//                   quantity: int.tryParse(quantityController.text) ?? 0,
//                   sales: int.tryParse(salesController.text) ?? 0,
//                 );
//
//                 // Add the product using ProductController
//                 productController.addProduct(newProduct);
//
//                 // Clear the form after adding the product
//                 nameController.clear();
//                 imagePathController.clear();
//                 categoryController.clear();
//                 priceController.clear();
//                 quantityController.clear();
//                 salesController.clear();
//
//                 // Navigate back to the previous screen
//                 Get.back();
//               },
//               child: Text('Add Product'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
