import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  //Signup
  Future <String> createAccountwithEmail(String email,String password) async {
    try{
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Account Created";
    }on FirebaseAuthException catch (e){
      return e.message.toString();
    }
  }

  //Login
  Future <String> loginwithEmail(String email,String password) async {
    try{
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Login Successful";
    }on FirebaseAuthException catch (e){
      return e.message.toString();
    }
  }

  //Logout
  Future logout() async {
      await FirebaseAuth.instance.signOut();
  }

  //reset password
  Future resetPassword(String email) async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return "Email Sent";
    }
    on FirebaseAuthException catch(e){
      return e.message.toString();
    }
  }

  //check whether user signed in or out
  Future <bool> isLoggedIn() async {
    var user=FirebaseAuth.instance.currentUser;
    return user!=null;
  }
}