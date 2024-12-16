import 'dart:convert';
import 'dart:io';
import 'package:ecommerceproject/global_controllers/text-field.dart';
import 'package:ecommerceproject/models/products-model.dart';
import 'package:ecommerceproject/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductPageAdmin extends StatefulWidget {
  @override
  _ProductPageAdminState createState() => _ProductPageAdminState();

}

class _ProductPageAdminState extends State<ProductPageAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _imagePathController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  String? _selectedCategory;
  File? _imageFile;
  List<String> _categories = ['Electronics', 'Fashion', 'Home', 'Beauty'];
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // Load products from shared preferences
  Future<void> _loadProducts() async {
    final List<Product> loadedProducts = await fetchProducts(); // Call fetchProducts directly
    setState(() {
      _products = loadedProducts; // Assign the fetched products
    });
  }

  // Fetch products from shared preferences
  Future<List<Product>> fetchProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> productJsonList = prefs.getStringList('products') ?? [];
    return productJsonList
        .map((jsonString) => Product.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  // Save products to shared preferences
  Future<void> _saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> productJsonList =
    _products.map((product) => jsonEncode(product.toJson())).toList();
    await prefs.setStringList('products', productJsonList);
  }

  // Function to pick an image from gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imagePathController.text = pickedFile.path;
      });
    }
  }

  // Function to handle the form submission for product
  void _submitProductForm({Product? product}) {
    if (_formKey.currentState!.validate()) {
      double? price = double.tryParse(_priceController.text);
      int? quantity = int.tryParse(_quantityController.text);

      if (price == null || price < 0 || quantity == null || quantity < 0) {
        Get.snackbar('Error', 'Invalid price or quantity');
        return;
      }

      setState(() {
        if (product == null) {
          _products.add(Product(
            name: _productNameController.text,
            imagePath: _imagePathController.text,
            category: _selectedCategory!,
            price: price,
            quantity: quantity,
            sales: 0,
          ));
        } else {
          product.name = _productNameController.text;
          product.imagePath = _imagePathController.text;
          product.category = _selectedCategory!;
          product.price = price;
          product.quantity = quantity;
          product.sales += 5;
        }
        _saveProducts();
      });
      Get.back();
    }
  }

  // Function to open the add product dialog
  void _openAddProductDialog() {
    _productNameController.clear();
    _imagePathController.clear();
    _priceController.clear();
    _quantityController.clear();
    _selectedCategory = null;
    _imageFile = null;

    _openDialog(title: 'Add Product');
  }

  // Function to open the edit product dialog
  void _openEditProductDialog(Product product) {
    _productNameController.text = product.name;
    _imagePathController.text = product.imagePath;
    _priceController.text = product.price.toString();
    _quantityController.text = product.quantity.toString();
    _selectedCategory = product.category;
    _imageFile = product.imagePath.isNotEmpty ? File(product.imagePath) : null;

    _openDialog(title: 'Edit Product', product: product);
  }

  void _openDialog({required String title, Product? product}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.mediumBlue,
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildTextField(
                    hintText: "Product Name",
                    controller: _productNameController,
                    inputType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  BuildTextField(
                    hintText: "Price",
                    controller: _priceController,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  BuildTextField(
                    hintText: "Quantity",
                    controller: _quantityController,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  _buildCategoryDropdown(),
                  SizedBox(height: 10),
                  _buildImagePicker(),
                  if (_imageFile != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Image.file(
                        _imageFile!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight:FontWeight.w400,
                  color: AppColors.mediumBlue,
                ),
              ),
            ),
            TextButton(
              onPressed: () => _submitProductForm(product: product),
              child: Text(
                  product == null ? 'Add Product' : 'Save Changes',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight:FontWeight.w400,
                  color: AppColors.mediumBlue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to delete a category
  void _deleteProduct(Product product) {
    setState(() {
      _products.remove(product);
      _saveProducts();
    });
  }

  DropdownButtonFormField<String> _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      onChanged: (newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
      decoration: InputDecoration(labelText: 'Select Category'),
      items: _categories.map((category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
      validator: (value) => value == null ? 'Please select a category' : null,
    );
  }

  // Build image picker widget
  Row _buildImagePicker() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: AppColors.buttonGradient,
          ),
          child: ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, // Make background transparent for gradient
              shadowColor: Colors.transparent, // Remove button shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r), // Ensure same border radius
              ),
            ),
            child: Text(
              'Pick an Image',
              style: TextStyle(color: Colors.white), // Adjust text color for visibility
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: BuildTextField(
            hintText: 'Image Path',
            controller: _imagePathController,
            inputType: TextInputType.url,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.mediumBlue,
            size: 30,
          ),
          onPressed: () {
            Get.back();
          },
        ),
          title: Text(
              'Products',
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.mediumBlue,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
      ),

      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            leading: product.imagePath.isNotEmpty
                ? Image.file(File(product.imagePath),
                width: 50.w, height: 70.h, fit: BoxFit.cover)
                : Icon(Icons.image),
            title: Text(product.name),
            subtitle:
            Text(
                'Category: ${product.category}\n Price: \$${product.price}',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _openEditProductDialog(product)),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteProduct(product)),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _openAddProductDialog,
        backgroundColor: AppColors.mediumBlue,
        elevation: 0,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
