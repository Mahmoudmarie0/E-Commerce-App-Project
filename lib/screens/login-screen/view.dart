import 'package:ecommerceproject/global_controllers/auth-service.dart';
import 'package:ecommerceproject/global_controllers/text-field.dart';
import 'package:ecommerceproject/screens/admin/admin-home.dart';
import 'package:ecommerceproject/screens/home-screen/view.dart';
import 'package:ecommerceproject/screens/register-screen/view.dart';
import 'package:ecommerceproject/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SingleChildScrollView(
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
                'Sign In',
                style: TextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mediumBlue,
                ),
              ),
              Text(
                'Get started with your account...',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                ),
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
                hintText: "Password",
                controller: passwordController,
                inputType: TextInputType.text,
                isPassword: !isPasswordVisible, // Set to false if password is visible
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: AppColors.mediumBlue,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible; // Toggle visibility
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialog(
                            title: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppColors.mediumBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Enter your Email",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.mediumBlue,
                                  ),
                                ),
                                SizedBox(height: 10.h),
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
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
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
                                onPressed: () async {
                                  if (emailController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          "Email cannot be empty",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor: Colors.red.shade400,
                                      ),
                                    );
                                    return;
                                  }
                                  await AuthService()
                                      .resetPassword(emailController.text)
                                      .then((value) {
                                    if (value == "Email Sent") {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Password reset link sent to your email",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            value,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.red.shade400,
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.mediumBlue,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppColors.mediumBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    AuthService()
                        .loginwithEmail(
                      emailController.text,
                      passwordController.text,
                    )
                        .then((value) {
                      if (value == "Login Successful") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Login Successful",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        // Check if the email is the admin email
                        if (emailController.text == 'maryammohamed.4m@gmail.com') {
                          Get.to(() => const AdminHome()); // Navigate to Admin Home
                        } else {
                          Get.to(() => const HomeScreen()); // Navigate to User Home
                        }
                      } else {
                        // If login fails, show a red SnackBar with "Incorrect username or password"
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "Incorrect username or password", // Custom error message
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red.shade400, // Red background
                          ),
                        );
                      }
                    }).catchError((e) {
                      // Handle any other errors, for example, network errors
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "An error occurred. Please try again.",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red.shade400,
                        ),
                      );
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
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15.sp,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const RegisterScreen());
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppColors.mediumBlue,
                        fontSize: 15.sp,
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
