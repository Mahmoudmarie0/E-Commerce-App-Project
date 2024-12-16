// import 'dart:convert';
// import 'dart:io';
// import 'package:ecommerceproject/models/products-model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';
//
// class ModifyProductProduct extends StatefulWidget {
//   final Product? product;
//
//   ModifyProductProduct({this.product});
//
//   @override
//   _ModifyProductProductState createState() => _ModifyProductProductState();
// }
//
// class _ModifyProductProductState extends State<ModifyProductProduct> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _productNameController = TextEditingController();
//   final TextEditingController _imagePathController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//
//   String? _selectedCategory;
//   File? _imageFile;
//   List<String> _categories = ['Electronics', 'Fashion', 'Home', 'Beauty'];
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.product != null) {
//       _productNameController.text = widget.product!.name;
//       _imagePathController.text = widget.product!.imagePath;
//       _priceController.text = widget.product!.price.toString();
//       _quantityController.text = widget.product!.quantity.toString();
//       _selectedCategory = widget.product!.category;
//       _imageFile = widget.product!.imagePath.isNotEmpty
//           ? File(widget.product!.imagePath)
//           : null;
//     }
//   }
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//         _imagePathController.text = pickedFile.path;
//       });
//     }
//   }
//
//   Future<void> _saveProduct() async {
//     if (_formKey.currentState!.validate()) {
//       double? price = double.tryParse(_priceController.text);
//       int? quantity = int.tryParse(_quantityController.text);
//
//       if (price == null || price < 0 || quantity == null || quantity < 0) {
//         Get.snackbar('Error', 'Invalid price or quantity');
//         return;
//       }
//
//       final product = Product(
//         id: widget.product?.id ?? Uuid().v4(),
//         name: _productNameController.text,
//         imagePath: _imagePathController.text,
//         category: _selectedCategory!,
//         price: price,
//         quantity: quantity,
//         sales: 0,
//       );
//
//       final prefs = await SharedPreferences.getInstance();
//       final List<String> productJsonList = prefs.getStringList('products') ?? [];
//       if (widget.product == null) {
//         // Add new product
//         productJsonList.add(jsonEncode(product.toJson()));
//       } else {
//         // Edit existing product
//         productJsonList.removeWhere((jsonString) =>
//         Product.fromJson(jsonDecode(jsonString)).id == widget.product!.id);
//         productJsonList.add(jsonEncode(product.toJson()));
//       }
//       await prefs.setStringList('products', productJsonList);
//
//       Get.back();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 _buildTextField(_productNameController, 'Product Name'),
//                 SizedBox(height: 10),
//                 _buildTextField(_priceController, 'Price',
//                     keyboardType: TextInputType.number),
//                 SizedBox(height: 10),
//                 _buildTextField(_quantityController, 'Quantity',
//                     keyboardType: TextInputType.number),
//                 SizedBox(height: 10),
//                 _buildCategoryDropdown(),
//                 SizedBox(height: 10),
//                 _buildImagePicker(),
//                 if (_imageFile != null)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Image.file(
//                       _imageFile!,
//                       height: 150,
//                       width: 150,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _saveProduct,
//                   child: Text(widget.product == null ? 'Add Product' : 'Save Changes'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   TextFormField _buildTextField(TextEditingController controller, String labelText,
//       {TextInputType keyboardType = TextInputType.text}) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(labelText: labelText),
//       keyboardType: keyboardType,
//       validator: (value) =>
//       value == null || value.isEmpty ? 'Please enter $labelText' : null,
//     );
//   }
//
//   DropdownButtonFormField<String> _buildCategoryDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedCategory,
//       onChanged: (newValue) {
//         setState(() {
//           _selectedCategory = newValue;
//         });
//       },
//       decoration: InputDecoration(labelText: 'Select Category'),
//       items: _categories.map((category) {
//         return DropdownMenuItem<String>(
//           value: category,
//           child: Text(category),
//         );
//       }).toList(),
//       validator: (value) => value == null ? 'Please select a category' : null,
//     );
//   }
//
//   Row _buildImagePicker() {
//     return Row(
//       children: [
//         ElevatedButton(onPressed: _pickImage, child: Text('Pick an Image')),
//         SizedBox(width: 10),
//         Expanded(
//           child: TextFormField(
//             controller: _imagePathController,
//             decoration: InputDecoration(labelText: 'Image Path'),
//             enabled: false,
//           ),
//         ),
//       ],
//     );
//   }
// }
