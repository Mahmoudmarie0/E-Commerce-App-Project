import 'package:ecommerceproject/screens/admin/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';

class CategoriesViewAdmin extends StatelessWidget {
  CategoriesViewAdmin({super.key});

  AdminController controller = Get.put(AdminController());

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
      body: GetBuilder<AdminController>(
        builder: (controller) {
          // Show loading indicator while fetching categories
          if (controller.categoriesLoader) {
            return Center(child: CircularProgressIndicator());
          }

          // Show list of categories
          return ListView.builder(
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return ListTile(
                title: Text(
                  category.name,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => controller.openEditCategoryDialog(category),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => controller.deleteCategoryById(category),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.openAddCategoryDialog,
        backgroundColor: AppColors.mediumBlue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
