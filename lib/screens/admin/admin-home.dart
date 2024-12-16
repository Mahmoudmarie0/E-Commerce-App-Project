import 'package:ecommerceproject/global_controllers/auth-service.dart';
import 'package:ecommerceproject/screens/admin/Container/category/categories-page.dart';
import 'package:ecommerceproject/screens/admin/Container/dashboard-text.dart';
import 'package:ecommerceproject/screens/admin/Container/home-button.dart';
import 'package:ecommerceproject/screens/login-screen/view.dart';
import 'package:ecommerceproject/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
                Get.to(() => const LoginScreen());
                },
              icon: const Icon(Icons.logout_outlined),
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
                    children: const [
                      DashboardText(
                        keyword: 'Total Products: ',
                        value: '100',
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
                      HomeButton(onTap: () {}, name: "Products"),
                      HomeButton(onTap: () {
                        Get.to(() => const CategoriesPageAdmin());
                        },
                          name: "Categories",
                      ),
                      HomeButton(onTap: () {}, name: "Coupons"),
                      HomeButton(onTap: () {}, name: "Promos"),
                      HomeButton(onTap: () {}, name: "Banners"),
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
