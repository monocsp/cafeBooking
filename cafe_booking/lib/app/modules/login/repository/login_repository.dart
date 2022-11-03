import 'dart:convert';
import 'dart:developer';

import 'package:cafe_booking/app/core/values/firebase_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginRepository {
  Future firebaseSignInWithCustomToken(token) async =>
      await FirebaseAuth.instance.signInWithCustomToken(token);

  Future firebaseSignUp(Map<String, dynamic> body) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: body['email'], password: body['password']);
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

  ///kakao로 로그인 할때 사용
  Future<bool> kakaoSignIn() async {
    kakao.User user;

    try {
      user = await kakao.UserApi.instance.me();
      log("USER : $user");
      log("USER properti : ${user.kakaoAccount}");

      // scopes.add("openid");
      // scopes.add("account_email");
      // kakao.OAuthToken kakaoToken;
      // kakaoToken = await UserApi.instance.loginWithNewScopes(scopes);

      final token = await createCustomToken({
        'uid': user.id.toString(),
        'provider': 'KAKAO',
        'email': (user.kakaoAccount?.email ?? "").toString()
      });
      log("TOKEN : $token");

      //Firebase oauth login
      await firebaseSignInWithCustomToken(token);

      return true;
    } catch (e) {
      log("USER Info Required Error : $e");
      return false;
    }
  }
}
