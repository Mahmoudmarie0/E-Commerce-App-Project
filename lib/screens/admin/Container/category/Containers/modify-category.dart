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
  final formKey=GlobalKey<FormState>();
  final ImagePicker picker=ImagePicker();
  late XFile? image;
  TextEditingController categoryController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController priorityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdating && widget.name != null) {
      categoryController.text = widget.name!;
      imageController.text = widget.image ?? '';
      priorityController.text = widget.priority.toString();
    }
  }

  //function to pick image using image picker
  Future<void>pickImage()async{
    image=await picker.pickImage(source:ImageSource.gallery);
    if(image!=null){
      String? res =await StorageService().uploadImage(image!.path, context);
      setState(() {
        if(res!=null){
          imageController.text=res;
          print("set image url $res: ${imageController.text}");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                  "Image uploaded successfully",
                ),
            ),
          );
        }
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.isUpdating?"Update Category":"Add Category",
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("All will be converted to lowercase"),
                SizedBox(height: 10.h,),
                BuildTextField(
                  hintText: "Category Name",
                  controller: categoryController,
                  inputType: TextInputType.text,
                  suffixIcon: const Icon(Icons.category_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This can't be empty.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h,),
                const Text("This will be used in ordering categories"),
                SizedBox(height: 10.h,),
                BuildTextField(
                  hintText: "Priority",
                  controller: priorityController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(Icons.low_priority_outlined),
                  validator: (value) {
                    value!.isEmpty?"This can't be empty.":null;
                    return null;
                  },
                ),
                SizedBox(height: 10.h,),
                image==null?imageController.text.isNotEmpty?
                    Container(
                      margin: const EdgeInsets.all(20),
                      height: 100.h,
                      width: double.infinity,
                      color: AppColors.mediumBlue,
                      child: Image.network(
                        imageController.text,
                        fit: BoxFit.contain,
                      ),
                    ):const SizedBox()
                :Container(
                  margin: const EdgeInsets.all(20),
                  height: 300.h,
                  width: double.infinity,
                  color: AppColors.mediumBlue,
                  child: Image.file(
                    File(image!.path),
                    fit: BoxFit.contain,
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      pickImage();
                    }
                    , child: const Text(
                  'Pick Image',
                ),
                ),
                BuildTextField(
                  hintText: "Image Link",
                  controller: imageController,
                  inputType: TextInputType.url,
                  suffixIcon: const Icon(Icons.image_outlined),
                  validator: (value) {
                    value!.isEmpty?"This can't be empty.":null;
                    return null;
                  },
                ),
              ],
            ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: (){
            Get.back();
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.mediumBlue,
            ),
          ),
        ),
        TextButton(
          onPressed: ()async{
            if(formKey.currentState!.validate()){
              if(widget.isUpdating){
                await DbService().updateCategories(
                    docId: widget.categoryId,
                    data: {
                      "name":categoryController.text.toLowerCase(),
                      "image":imageController.text,"priority":int.parse(priorityController.text),
                    },
                );
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Category Updated",
                      ),
                    ));
              }else{
                await DbService().createCategories(
                  data:{
                    "name":categoryController.text.toLowerCase(),
                    "image":imageController.text,"priority":int.parse(priorityController.text),
                  }
                );
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            "Category Added",
                        ),
                    ));
              }
              Get.back();
            }
          },
          child: Text(
            widget.isUpdating?"Update":"Add",
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.mediumBlue,
            ),
          ),
        ),
      ],
    );
  }
}
