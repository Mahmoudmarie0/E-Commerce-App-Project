import 'package:ecommerceproject/global_controllers/auth-service.dart';
import 'package:ecommerceproject/screens/home-screen/view.dart';
import 'package:ecommerceproject/screens/login-screen/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState(){
    AuthService().isLoggedIn().then((value){
      if(value){
        Get.to(() => const HomeScreen());
      }else{
        Get.to(() =>  LoginScreen());
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
