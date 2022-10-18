import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  Future signUp(Map<String, dynamic> body) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: body['email'], password: body['password']);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log('$e');
    }
  }
}
