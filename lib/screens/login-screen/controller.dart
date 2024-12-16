import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController
{
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool rememberMe = false;



  Future<void> addUserToFirestore(String email) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');


      DocumentSnapshot userDoc = await users.doc(email).get();
      if (!userDoc.exists) {

        await users.doc(email).set({
          'email': email,
          'createdAt': DateTime.now(),
          // Add more fields as needed
        });
        print("User added to Firestore");
      } else {
        print("User already exists in Firestore");
      }
    } catch (e) {
      print("Error adding user to Firestore: $e");
    }
  }
}
