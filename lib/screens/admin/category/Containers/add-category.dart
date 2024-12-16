// import 'dart:io';
//
// import 'package:ecommerceproject/global_controllers/admin_controller.dart';
// import 'package:ecommerceproject/global_controllers/storage-service.dart';
// import 'package:ecommerceproject/global_controllers/text-field.dart';
// import 'package:ecommerceproject/models/categories-model.dart';
// import 'package:ecommerceproject/utils/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class AddCategoryDialog extends StatefulWidget {
//   @override
//   State<AddCategoryDialog> createState() => _AddCategoryDialogState();
// }
//
// class _AddCategoryDialogState extends State<AddCategoryDialog> {
//   final ImagePicker picker = ImagePicker();
//
//   late XFile? image = null;
//
//   final TextEditingController categoryController = TextEditingController();
//
//   final TextEditingController priorityController = TextEditingController();
//
//   final TextEditingController imageController = TextEditingController();
//
//   Future<void> pickImage() async {
//     try {
//       image = await picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         String? res = await StorageService().uploadImage(image!.path, context);
//         if (res != null) {
//           setState(() {
//             imageController.text = res;
//           });
//         }
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Error: ${e.toString()}"),
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final AdminController controller = Get.find<AdminController>();
//
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             BuildTextField(
//               hintText: "Category Name",
//               controller: categoryController,
//               inputType: TextInputType.text,
//               validator: (value) => value == null || value.isEmpty ? "Cannot be empty" : null,
//             ),
//             SizedBox(height: 10.h),
//             BuildTextField(
//               hintText: "Priority",
//               controller: priorityController,
//               inputType: TextInputType.number,
//               validator: (value) => value == null || value.isEmpty ? "Cannot be empty" : null,
//             ),
//             SizedBox(height: 10.h),
//             image == null && imageController.text.isNotEmpty
//                 ? Container(
//               margin: EdgeInsets.all(20),
//               height: 100.h,
//               width: double.infinity,
//               color: AppColors.mediumBlue,
//               child: Image.network(
//                 imageController.text,
//                 fit: BoxFit.contain,
//               ),
//             )
//                 : image != null
//                 ? Container(
//               margin: EdgeInsets.all(20),
//               height: 200.h,
//               width: double.infinity,
//               color: AppColors.mediumBlue,
//               child: Image.file(
//                 File(image!.path),
//                 fit: BoxFit.contain,
//               ),
//             )
//                 : SizedBox(),
//             ElevatedButton(
//               onPressed: () {
//                 pickImage();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.mediumBlue,
//               ),
//               child: Text('Pick Image'),
//             ),
//             SizedBox(height: 10.h),
//             BuildTextField(
//               hintText: "Image Link",
//               controller: imageController,
//               inputType: TextInputType.url,
//               suffixIcon: Icon(Icons.image_outlined),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "This can't be empty.";
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height:20.h),
//             // Add Category Button
//             ElevatedButton(
//               onPressed: () {
//                 controller.addCategory(
//                   CategoriesModel(
//                     name: categoryController.text,
//                     priority: int.tryParse(priorityController.text) ?? 0,
//                     image: imageController.text, id: '',
//                   ),
//                 );
//                 Get.back(); // Close the dialog after adding the category
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.mediumBlue,
//               ),
//               child: Text('Add Category'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
