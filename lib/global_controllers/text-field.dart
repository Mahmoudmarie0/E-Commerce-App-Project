import 'package:ecommerceproject/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool isPassword;

  const BuildTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.inputType,
    this.suffixIcon,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: widget.isPassword,
      cursorColor: AppColors.mediumBlue,
      decoration: InputDecoration(

        suffixIcon: widget.suffixIcon,
        labelText: widget.hintText,
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
          borderSide: BorderSide(
            color: AppColors.mediumBlue,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
