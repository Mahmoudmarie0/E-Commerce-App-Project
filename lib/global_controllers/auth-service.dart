import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  // Signup
  Future<String> createAccountwithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Account Created";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // Login
  Future<String> loginwithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Login Successful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // Logout
  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // Reset password
  Future resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return "Email Sent";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // Check whether user is signed in or out
  Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  // Fetch current user's data from Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Fetch the user document from the "users" collection using the user's UID
        DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (snapshot.exists) {
          return snapshot.data() as Map<String, dynamic>;
        } else {
          return null;
        }
      } catch (e) {
        print("Error fetching user data: $e");
        return null;
      }
    }
    return null;
  }
}
