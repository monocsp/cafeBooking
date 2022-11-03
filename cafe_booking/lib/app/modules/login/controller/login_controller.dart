import 'dart:developer';
import 'dart:io';

import 'package:cafe_booking/app/data/hive_enum.dart';
import 'package:cafe_booking/app/modules/login/repository/login_repository.dart';
import 'package:cafe_booking/firebase_options.dart';
import 'package:cafe_booking/uitilites/abstract.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'social/abstract_login.dart';

class LoginController extends CustomGetxController {
  static LoginController get to => Get.find();
  final loginHiveBox = Hive.box(LoginHiveEnum.openBox.openBoxName);
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  TextEditingController emailTextEditingController = TextEditingController()
    ..addListener(() {});
  TextEditingController passwordTextEditingController = TextEditingController();

  PageController pageController = PageController(
    initialPage: 0,
  );

  changePage(int page) {
    pageController.animateToPage(page,
        duration: const Duration(
          milliseconds: 600,
        ),
        curve: Curves.easeOutQuint);
  }

  RxBool confirmEmail = false.obs;
  RxBool confirmPassword = false.obs;
  RxBool passwordVisible = true.obs;
  //로그인상태 확인
  RxBool _loginStatus = false.obs;
  RxBool autoLoginStatus = false.obs;

  bool get isConfirmLogin => _loginStatus.value;

  updateLoginStatus(bool state) {
    _loginStatus(state);
  }

  @override
  void onInit() {
    super.onInit();

    pageController.addListener(() {
      Get.focusScope!.unfocus();
    });

    autoLogin();
    //이메일 형식이 맞는지 확인
    emailTextEditingController.addListener(() {
      if (EmailValidator.validate(emailTextEditingController.text)) {
        confirmEmail(true);
        return;
      }
      confirmEmail(false);
    });

    passwordTextEditingController.addListener(() {
      //비밀번호 최소 6자리 이상
      if (passwordTextEditingController.text.length > 5) {
        confirmPassword(true);
      } else {
        confirmPassword(false);
      }
    });
  }

  autoLogin() {
    int? checkAutoLogin = loginHiveBox.get(LoginHiveEnum.autoLogin.hiveKey) ?? 0;
    if (checkAutoLogin == 1) {
      autoLoginStatus(true);
      return;
    }
  }

  ///일반적인 이메일 회원가입 시 사용하는 함수
  Future firebaseSignUp() async {
    await LoginRepository()
        .firebaseSignUp({'email': 'ckstjq987@naver.com', 'password': 'ckstjq987'});
  }

  ///구글로 로그인하기
  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    var platformClientId;
    try {
      if (Platform.isAndroid) {
        platformClientId = DefaultFirebaseOptions.currentPlatform.androidClientId;
      } else if (Platform.isIOS) {
        platformClientId = DefaultFirebaseOptions.currentPlatform.iosClientId;
      }
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(clientId: platformClientId).signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log("Google sign in error :$e");
      return null;
    }
  }

  Future<bool> signInWithKakao(SocialLogin socialLogin) async {
    // //로그인이 실패하거나
    // //로그인했지만, kakao oauth token을 firebase oauth와 연동에 실패했을 때
    bool openKakaoSignIn = await socialLogin.login();

    if (!openKakaoSignIn) {
      return false;
    }
    bool kakaoSignInStatus = await LoginRepository().kakaoSignIn();
    if (!kakaoSignInStatus) {
      return false;
    }
    _loginStatus(true);
    return true;
  }

  // Future logoutWithKakao() async {
  //   await _socialLogin.logout();
  //   await FirebaseAuth.instance.signOut();
  //   isLogined = false;
  //   user = null;
  // }
}
