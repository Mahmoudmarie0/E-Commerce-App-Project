import 'package:ecommerceproject/screens/login-screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {

   ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  LoginController controller = Get.put(LoginController());

  DateTime? selectedBirthDate; // New field for birthdate
  final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    _loadUserBirthdate(); // Load birthdate from Firestore when the page loads
  }

  /// Save the selected birthdate to Firestore
  Future<void> _saveBirthdateToFirestore(DateTime birthdate) async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('users');

      await usersCollection.doc(controller.emailController.text).set(
        {'birthdate': birthdate.toIso8601String()},
        SetOptions(merge: true), // Merge to avoid overwriting existing data
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Birthdate saved successfully!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to save birthdate: $e',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Load the user's birthdate from Firestore
  Future<void> _loadUserBirthdate() async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('users');

      DocumentSnapshot userDoc = await usersCollection.doc(controller.emailController.text).get();
      if (userDoc.exists && userDoc['birthdate'] != null) {
        setState(() {
          selectedBirthDate = DateTime.parse(userDoc['birthdate']);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to load birthdate: $e',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Show the date picker to select a birthdate
  void _selectBirthDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xff034078),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child ?? const SizedBox(),
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedBirthDate = pickedDate;
      });
      _saveBirthdateToFirestore(pickedDate); // Save the selected birthdate
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff034078),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Email: ${controller.emailController.text}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Birthdate: ${selectedBirthDate != null ? dateFormatter.format(selectedBirthDate!) : 'Not Set'}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: _selectBirthDate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff034078),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Select',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
