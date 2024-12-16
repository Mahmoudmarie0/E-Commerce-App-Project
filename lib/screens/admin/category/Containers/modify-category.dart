import 'dart:io';
import 'package:ecommerceproject/global_controllers/db-service.dart';
import 'package:ecommerceproject/global_controllers/storage-service.dart';
import 'package:ecommerceproject/global_controllers/text-field.dart';
import 'package:ecommerceproject/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ModifyCategory extends StatefulWidget {
  final bool isUpdating;
  final String? name;
  final String categoryId;
  final String? image;
  final int priority;

  const ModifyCategory({
    super.key,
    required this.isUpdating,
    this.name,
    required this.categoryId,
    this.image,
    required this.priority,
  });

  @override
  State<ModifyCategory> createState() => _ModifyCategoryState();
}

class _ModifyCategoryState extends State<ModifyCategory> {
  final formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  late XFile? image = null;
  TextEditingController categoryController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdating && widget.name != null) {
      categoryController.text = widget.name!;
      imageController.text = widget.image ?? '';
      priorityController.text = widget.priority.toString();
    }
  }

  Future<void> pickImage() async {
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        String? res = await StorageService().uploadImage(image!.path, context);
        if (res != null) {
          setState(() {
            imageController.text = res;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: ${e.toString()}"),
      ));
    }
  }

  Future<void> deleteCategoryWithProducts(String categoryId, String? imageUrl) async {
    try {
      // Delete products linked to this category
      await DbService().deleteProductsByCategoryId(categoryId);

      // Delete category image if exists
      if (imageUrl != null && imageUrl.isNotEmpty) {
        await StorageService().deleteImage(imageUrl);
      }

      // Delete category itself
      await DbService().deleteCategory(docId: categoryId);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category and linked products deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting category: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isUpdating ? "Update Category" : "Add Category"),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              BuildTextField(
                hintText: "Category Name",
                controller: categoryController,
                inputType: TextInputType.text,
                suffixIcon: const Icon(Icons.category_outlined),
                validator: (value) => value == null || value.isEmpty ? "Cannot be empty" : null,
              ),
              SizedBox(height: 10.h),
              BuildTextField(
                hintText: "Priority",
                controller: priorityController,
                inputType: TextInputType.number,
                suffixIcon: const Icon(Icons.low_priority_outlined),
                validator: (value) => value == null || value.isEmpty ? "Cannot be empty" : null,
              ),
              SizedBox(height: 10.h),
              image == null && imageController.text.isNotEmpty
                  ? Container(
                margin: EdgeInsets.all(20),
                height: 100.h,
                width: double.infinity,
                color: AppColors.mediumBlue,
                child: Image.network(
                  imageController.text,
                  fit: BoxFit.contain,
                ),
              )
                  : image != null
                  ? Container(
                margin: EdgeInsets.all(20),
                height: 200.h,
                width: double.infinity,
                color: AppColors.mediumBlue,
                child: Image.file(
                  File(image!.path),
                  fit: BoxFit.contain,
                ),
              )
                  : SizedBox(),
              ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: Text('Pick Image'),
              ),
              SizedBox(height: 10.h),
              BuildTextField(
                hintText: "Image Link",
                controller: imageController,
                inputType: TextInputType.url,
                suffixIcon: Icon(Icons.image_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This can't be empty.";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              final data = {
                "name": categoryController.text.toLowerCase(),
                "priority": int.parse(priorityController.text),
                "image": imageController.text,
              };

              if (widget.isUpdating) {
                await DbService().updateCategory(docId: widget.categoryId, data: data);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Category Updated")));
              } else {
                await DbService().createCategory(data: data);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Category Added")));
              }
              Get.back();
            }
          },
          child: Text(widget.isUpdating ? "Update" : "Add"),
        ),
        if (widget.isUpdating)
          TextButton(
            onPressed: () => deleteCategoryWithProducts(widget.categoryId, widget.image),
            child: const Text("Delete"),
          ),
      ],
    );
  }
}
