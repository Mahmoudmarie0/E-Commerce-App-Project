import 'package:ecommerceproject/screens/admin/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';

class ProductsViewAdmin extends StatelessWidget {
  ProductsViewAdmin({super.key});

  AdminController controller = Get.put(AdminController());

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

      body: GetBuilder<AdminController>(
        init: AdminController(),
        builder: (controller) {
          // Show loading indicator while fetching products
          if (controller.productsLoader) {
            return Center(child: CircularProgressIndicator());
          }

          // Show list of products
          return ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return ListTile(
                leading: product.image.isNotEmpty
                    ? Image.network(
                  product.image,
                  width: 50.w,
                  height: 70.h,
                  fit: BoxFit.cover,
                )
                    : Icon(Icons.image),
                title: Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                subtitle: Text(
                  'Category: ${product.category.name}\nPrice: \$${product.price.toStringAsFixed(2)}',
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
                        onPressed: () => controller.openEditProductDialog(product)),
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.deleteProductById(product)),
                  ],
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: controller.openAddProductDialog,
        backgroundColor: AppColors.mediumBlue,
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
