import 'dart:developer';

import 'package:cafe_booking/data/hive_enum.dart';
import 'package:cafe_booking/screens/login/controller/login_controller.dart';
import 'package:cafe_booking/uitilites/sources.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

class LoginMainPage extends GetView<LoginController> {
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: complementaryColor,
              ),
              onPressed: () => controller.changePage(0)),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(

              ///전체 스크린사이즈에서
              ///statusbar
              ///appbar사이즈를 제외한 전체사이즈
              height: Get.size.height -
                  Get.mediaQuery.viewPadding.top -
                  AppBar().preferredSize.height,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: space_xxl,
              ),
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: firebaseAuthLogin(),
                    ),
                    Flexible(flex: 1, child: socialSNSOAuth())
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Obx passwordTextFormField() {
    return Obx(() => TextFormField(
          focusNode: passwordFocusNode,
          maxLines: 1,
          maxLength: 12,
          obscureText: controller.passwordVisible.value,
          controller: controller.passwordTextEditingController,
          validator: (value) {
            if (controller.passwordTextEditingController.text.length < 6) {
              return '최소 6자리 이상으로 설정해야합니다.';
            }
            return null;
          },
          decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.key,
                color: complementaryColor,
              ),
              hintMaxLines: 1,
              hintText: '최소 6자리로 설정해주세요',
              suffixIcon: IconButton(
                  icon: Icon(
                    controller.passwordVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: !controller.confirmPassword.value
                        ? complementaryColor
                        : Colors.green,
                  ),
                  onPressed: () {
                    controller
                        .passwordVisible(!controller.passwordVisible.value);
                  }),
              border: myinputborder(),
              focusedBorder: myfocusborder()),
        ));
  }

  Widget emailTextFormField() {
    return Form(
      key: controller.emailFormKey,
      child: TextFormField(
        inputFormatters: [
          //특수문자 제외
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]')),
        ],
        maxLines: 1,
        maxLength: 30,
        controller: controller.emailTextEditingController,
        validator: (value) {
          log('value : $value');
          if (controller.confirmEmail.value) return null;

          if (!EmailValidator.validate(
              controller.emailTextEditingController.text))
            return '이메일형식이 아닙니다.';
        },
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.mail,
              color: complementaryColor,
            ),
            hintMaxLines: 1,
            hintText: 'example@gmail.com',
            suffixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: !controller.confirmEmail.value
                  ? IconButton(
                      // key: cost ValueKey<int>(0),
                      icon: const Icon(
                        Icons.cancel,
                        color: complementaryColor,
                      ),
                      onPressed: () {
                        controller.emailTextEditingController.text = '';
                      })
                  : const Icon(
                      // key: ValueKey<int>(1),
                      Icons.check,
                      color: Colors.green,
                    ),
            ),
            border: myinputborder(),
            focusedBorder: myfocusborder()),
      ),
    );
  }

  Widget firebaseAuthLogin() {
    return Form(
      key: controller.emailFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '아이디',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: complementaryColor),
              ),
              emailTextField(),
            ],
          ),

          // emailTextFormField(),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '비밀번호',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: complementaryColor),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  passwordTextFormField(),
                  Obx(
                    () => SizedBox(
                      width: Get.size.width / 2,
                      child: CheckboxListTile(
                          activeColor: primeColor,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text(
                            '자동로그인',
                            style: TextStyle(color: complementaryColor),
                          ),
                          value: controller.autoLoginStatus.value,
                          onChanged: (bool? value) {
                            value ??= false;
                            if (value) {
                              controller.loginHiveBox
                                  .put(LoginHiveEnum.autoLogin.hiveKey, 1);
                            } else {
                              controller.loginHiveBox
                                  .put(LoginHiveEnum.autoLogin.hiveKey, 0);
                            }
                            log('controller.loginHiveBox.get(LoginHiveEnum.autoLogin.hiveKey) : ${controller.loginHiveBox.get(LoginHiveEnum.autoLogin.hiveKey)}');
                            controller.autoLoginStatus(value);
                          }),
                    ),
                  ),
                ],
              ),
            ],
          ),

          ///회원가입 버튼
          InkWell(
              borderRadius: default_borderRadius,
              onTap: () async {
                controller.emailFormKey.currentState?.validate();
                controller.passwordFormKey.currentState?.validate();

                if (!controller.confirmEmail.value) return;
                if (!controller.confirmPassword.value) return;

                LoginController.to.updateLoginStatus(true);
                // LoginController.to.

                // if (!controller.confirmEmail.value) {
                //   return;
                // }
                // await controller.signUp();
              },
              child: Container(
                width: Get.size.width,
                height: 60,
                decoration: const BoxDecoration(
                    color: primeColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    )),
                alignment: Alignment.center,
                child: const Text(
                  '이메일로 회원가입',
                  style: TextStyle(color: complementaryColor, fontSize: 20),
                ),
              )),
        ],
      ),
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      onEditingComplete: () {
        //done클릭 시 password로 넘어감.
        passwordFocusNode.requestFocus();
      },
      inputFormatters: [
        //특수문자 제외
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]')),
      ],
      maxLines: 1,
      maxLength: 30,
      controller: controller.emailTextEditingController,
      validator: (value) {
        // log('value : $value');
        if (controller.confirmEmail.value) return null;

        if (!EmailValidator.validate(
            controller.emailTextEditingController.text)) {
          return '이메일형식이 아닙니다.';
        }
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.mail,
            color: complementaryColor,
          ),
          hintMaxLines: 1,
          hintText: 'example@gmail.com',
          suffixIcon: Obx(() {
            // log("here");
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: !controller.confirmEmail.value
                  ? IconButton(
                      // key: cost ValueKey<int>(0),
                      icon: const Icon(
                        Icons.cancel,
                        color: complementaryColor,
                      ),
                      onPressed: () {
                        controller.emailTextEditingController.text = '';
                      })
                  : const Icon(
                      // key: ValueKey<int>(1),
                      Icons.check,
                      color: Colors.green,
                    ),
            );
          }),
          border: myinputborder(),
          focusedBorder: myfocusborder()),
    );
  }

  Widget socialSNSOAuth() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {},
            child:
                Image.asset("assets/images/login/kakao_login_large_wide.png")),
        SizedBox(
          width: Get.size.width,
          child: SignInButton(
            Buttons.Google,
            onPressed: () {
              controller.signInWithGoogle();
            },
          ),
        )
      ],
    );
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 3,
      ));
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.deepPurple,
        width: 3,
      ));
}
