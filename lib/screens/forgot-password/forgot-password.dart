import 'package:ecommerceproject/global_controllers/auth-service.dart';
import 'package:ecommerceproject/global_controllers/text-field.dart';
import 'package:ecommerceproject/screens/login-screen/view.dart';
import 'package:ecommerceproject/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mediumBlue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
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
                hintText: "Enter Password",
                controller: passwordController,
                inputType: TextInputType.text,
                isPassword: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: AppColors.mediumBlue,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;  
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
              BuildTextField(
                hintText: "Confirm Password",
                controller: confirmPasswordController,
                inputType: TextInputType.text,
                isPassword: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: AppColors.mediumBlue,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value.length < 6) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  if (passwordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Please fill in all fields",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red.shade400,
                      ),
                    );
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Passwords do not match",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red.shade400,
                      ),
                    );
                  } else {
                    AuthService()
                        .resetPassword(emailController.text)
                        .then((value) {
                      if (value == "Email Sent") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Password reset link sent to your email",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
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
                      'Submit',
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
                    "Go back to ",
                    style: TextStyle(color: Colors.grey.shade600),
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
    );
  }
}
