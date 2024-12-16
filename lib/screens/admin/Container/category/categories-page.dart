import 'package:ecommerceproject/models/categories-model.dart';
import 'package:ecommerceproject/providers/admin-provider.dart';
import 'package:ecommerceproject/screens/admin/Container/category/Containers/modify-category.dart';
import 'package:ecommerceproject/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CategoriesPageAdmin extends StatefulWidget {
  const CategoriesPageAdmin({super.key});

  @override
  State<CategoriesPageAdmin> createState() => _CategoriesPageAdminState();
}

class _CategoriesPageAdminState extends State<CategoriesPageAdmin> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final adminProvider = Provider.of<AdminProvider>(context, listen: false);
      debugPrint(adminProvider.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, adminProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
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
          backgroundColor: AppColors.scaffoldLightColor,
          elevation: 2,
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) {
            List<CategoriesModel> categories = [];
            try {
              categories = CategoriesModel.fromJsonList(adminProvider.categories);
            } catch (e) {
              debugPrint('Error parsing categories: $e');
            }

            if (categories.isEmpty) {
              return const Center(
                child: Text("No Categories found"),
              );
            }

            return ListView.builder(
              itemCount: adminProvider.categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    height: 50.h,
                    width: 50.w,
                    child: Image.network(
                      categories[index].image==""?
                    "https://demofree.sirv.com/nope-not-here.jpg":categories[index].image
                    ),
                  ),
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context)=>
                            AlertDialog(
                              title: const Text("What do you want to do?"),
                              content: const Text("Delete action can't be undon"),
                              actions: [
                                TextButton(onPressed:(){}, child: const Text("Delete Category")),
                                TextButton(onPressed:(){
                                  Get.back();
                                  showDialog(
                                    context: context,
                                    builder: (context) => ModifyCategory(
                                      isUpdating: true,
                                      categoryId: categories[index].id,
                                      priority: categories[index].priority,
                                      image: categories[index].image,
                                      name: categories[index].name,
                                    ),
                                  );
                                },
                                    child: const Text("Update Category")),
                              ],
                            )
                    );
                  },
                  title: Text(
                    categories[index].name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "Priority: ${categories[index].priority}",
                  ),
                  trailing:IconButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) => ModifyCategory(
                            isUpdating: true,
                            categoryId: categories[index].id,
                            priority: categories[index].priority,
                            image: categories[index].image,
                            name: categories[index].name,
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit_outlined),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const ModifyCategory(
                isUpdating: false,
                categoryId: "",
                priority: 0,
                image: "",
                name: ""
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
