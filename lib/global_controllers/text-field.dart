import 'package:ecommerceproject/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool isPassword;

  const BuildTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.inputType,
    this.suffixIcon,
    this.validator,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isPassword,
      cursorColor: AppColors.mediumBlue,
      decoration: InputDecoration(

        suffixIcon: suffixIcon,
        labelText: hintText,
        labelStyle: TextStyle(
          color: Colors.grey.shade600,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: AppColors.mediumBlue,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
