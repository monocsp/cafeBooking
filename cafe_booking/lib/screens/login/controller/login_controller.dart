import 'dart:developer';

import 'package:cafe_booking/data/hive_enum.dart';
import 'package:cafe_booking/screens/login/repository/login_repository.dart';
import 'package:cafe_booking/uitilites/abstract.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    int? checkAutoLogin =
        loginHiveBox.get(LoginHiveEnum.autoLogin.hiveKey) ?? 0;
    if (checkAutoLogin == 1) {
      autoLoginStatus(true);
      return;
    }
  }

  Future signUp() async {
    await LoginRepository()
        .signUp({'email': 'ckstjq987@naver.com', 'password': 'ckstjq987'});
  }
}
