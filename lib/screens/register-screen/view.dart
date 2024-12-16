import 'package:ecommerceproject/global_controllers/auth-service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerceproject/screens/login-screen/view.dart';
import 'package:ecommerceproject/utils/constants/colors.dart';
import 'package:ecommerceproject/global_controllers/text-field.dart';
import 'package:get_storage/get_storage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 20.r,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.mediumBlue,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mediumBlue,
                  ),
                ),
                Text(
                  'Create a new account and get started...',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 10.h),
                BuildTextField(
                  hintText: "Full Name",
                  controller: nameController,
                  inputType: TextInputType.text,
                  suffixIcon: const Icon(
                    Icons.person_2_outlined,
                    color: AppColors.mediumBlue,
                  ),
                ),
                SizedBox(height: 20.h),
                BuildTextField(
                  hintText: "Email Address",
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
                  suffixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.mediumBlue,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                BuildTextField(
                  hintText: "Password",
                  controller: passwordController,
                  inputType: TextInputType.text,
                  isPassword: !isPasswordVisible,  // Set to false if password is visible
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: AppColors.mediumBlue,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;  // Toggle visibility
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AuthService()
                          .createAccountwithEmail(
                        emailController.text,
                        passwordController.text,
                      )
                          .then((value) {
                        if (value == "Account Created") {
                          // Save the name in GetStorage
                          box.write('userName', nameController.text);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(
                              "Account Created"
                              ,style: TextStyle(
                              color: Colors.white,
                            ),),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Get.to(() => LoginScreen());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                value,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red.shade400,
                            ),
                          );
                        }
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: AppColors.buttonGradient,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      alignment: Alignment.center,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.offWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() =>  LoginScreen());
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppColors.mediumBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
