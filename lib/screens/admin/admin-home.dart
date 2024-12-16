import 'package:ecommerceproject/global_controllers/auth-service.dart';
import 'package:ecommerceproject/global_controllers/product-controller.dart';
import 'package:ecommerceproject/models/products-model.dart';
import 'package:ecommerceproject/screens/admin/Container/dashboard-text.dart';
import 'package:ecommerceproject/screens/admin/Container/home-button.dart';
import 'package:ecommerceproject/screens/admin/bestSelling/bestSelling-page.dart';
import 'package:ecommerceproject/screens/admin/category/categories-page.dart';
import 'package:ecommerceproject/screens/admin/feedback/feedback-page.dart';
import 'package:ecommerceproject/screens/admin/report/transaction-report.dart';
import 'package:ecommerceproject/screens/login-screen/view.dart';
import 'package:ecommerceproject/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'products/products-page.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List<Product> _products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
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
        actions: [
          IconButton(
              onPressed: (){
                AuthService().logout();
                Get.to(() => LoginScreen());
                },
              icon: Icon(Icons.logout_outlined),
          )
        ],
        backgroundColor: AppColors.scaffoldLightColor,
        elevation: 2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowLightColor,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      DashboardText(
                        keyword: 'Total Products: ',
                        value: '${_products.length}',
                      ),
                      // SizedBox(height: 5.h),
                      DashboardText(
                        keyword: 'Total Orders: ',
                        value: '50',
                      ),
                      // SizedBox(height: 5.h),
                      DashboardText(
                        keyword: 'Total Users: ',
                        value: '200',
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      HomeButton(onTap: () {}, name: "Orders"),
                      HomeButton(onTap: () {
                        Get.to(() => ProductPageAdmin());
                      }, name: "Products"),
                      HomeButton(onTap: () {
                        Get.to(() => CategoryPageAdmin());
                        },
                          name: "Categories",
                      ),
                      HomeButton(onTap: () {
                        Get.to(() => TransactionReportPage());
                      }, name: "Report"),
                      HomeButton(onTap: () {
                        Get.to(() => AdminFeedbackPage());
                      }, name: "Feedback"),
                      HomeButton(onTap: () {
                        final productController = Get.find<ProductController>();
                        Get.to(() => BestSellingChart(products: productController.products));
                      }, name: "Best Selling"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
