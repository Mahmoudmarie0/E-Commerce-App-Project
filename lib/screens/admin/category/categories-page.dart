import 'dart:convert';
import 'package:ecommerceproject/global_controllers/text-field.dart';
import 'package:ecommerceproject/models/categories-model.dart';
import 'package:ecommerceproject/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryPageAdmin extends StatefulWidget {
  @override
  _CategoryPageAdminState createState() => _CategoryPageAdminState();
}

class _CategoryPageAdminState extends State<CategoryPageAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  // Load categories from shared preferences
  Future<void> _loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> categoryJsonList = prefs.getStringList('categories') ?? [];

    setState(() {
      _categories = categoryJsonList
          .map((jsonString) {
        try {
          final Map<String, dynamic> categoryMap = json.decode(jsonString);
          return Category.fromMap(categoryMap);
        } catch (e) {
          print('Invalid JSON string: $jsonString. Error: $e');
          return null;
        }
      })
          .where((category) => category != null)
          .cast<Category>()
          .toList();
    });
  }

  // Save categories to shared preferences
  Future<void> _saveCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> categoryJsonList =
    _categories.map((category) => jsonEncode(category.toMap())).toList();
    await prefs.setStringList('categories', categoryJsonList);
  }


  // Handle form submission
  void _submitCategoryForm({Category? category}) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (category == null) {
          _categories.add(Category(
            name: _categoryNameController.text,
          ));
        } else {
          category.name = _categoryNameController.text;
        }
        _saveCategories();
      });
      Get.back();
    }
  }

  // Open add category dialog
  void _openAddCategoryDialog() {
    _categoryNameController.clear();
    _openDialog(title: 'Add Category');
  }

  // Open edit category dialog
  void _openEditCategoryDialog(Category category) {
    _categoryNameController.text = category.name;
    _openDialog(title: 'Edit Category', category: category);
  }

  // Open dialog for adding/editing categories
  void _openDialog({required String title, Category? category}) {
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
                      hintText: "Category Name",
                    controller: _categoryNameController,
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
              onPressed: () => _submitCategoryForm(category: category),
              child: Text(
                  category == null ? 'Add Category' : 'Save Changes',
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

  // Delete a category
  void _deleteCategory(Category category) {
    setState(() {
      _categories.remove(category);
      _saveCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.mediumBlue, size: 30),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Categories',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.mediumBlue,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return ListTile(
            title:  Text(
              "Category: ${category.name}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _openEditCategoryDialog(category)),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteCategory(category)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddCategoryDialog,
        backgroundColor: AppColors.mediumBlue,
        child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
        ),
      ),
    );
  }
}
