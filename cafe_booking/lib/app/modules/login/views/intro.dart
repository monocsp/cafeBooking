import 'package:cafe_booking/app/modules/login/controller/login_controller.dart';
import 'package:cafe_booking/uitilites/sources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_main_page.dart';

class IntroPage extends GetView<LoginController> {
  bool login = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double welcomeTextHeight = Get.size.height / 12;
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
          physics: const BouncingScrollPhysics(),
          controller: LoginController.to.pageController,
          children: [introWidget(welcomeTextHeight), LoginMainPage()]),
    );
  }

  Column introWidget(double welcomeTextHeight) {
    return Column(
      children: [
        Container(
            height: Get.size.height / 1.8,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height: 50,
                // ),

                // top: Get.size.height / 4,
                // height: (Get.size.height / 1.65) / 3,
                // width: Get.size.width,

                Image.asset(
                  'assets/images/intro/intro_shop_icon.png',
                  width: 200,
                ),
              ],
            )),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: primeColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: space_xxl,
              ),
              child: buildBottomStack(welcomeTextHeight),
            ),
          ),
        ),
      ],
    );
  }

  Stack buildBottomStack(double welcomeTextHeight) {
    return Stack(children: [
      Positioned(
        top: welcomeTextHeight,
        child: const Text(
          "안녕하세요!",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      Positioned(
        top: welcomeTextHeight + 40,
        child: const Text(
          "전국의 모든 사장님 및 알바생을 위한 어플입니다.",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      Positioned(
        bottom: Get.height / 20,
        child: GestureDetector(
          onTap: () {
            controller.changePage(1);
            // Get.toNamed('/LoginMainPage');
          },
          child: Container(
            decoration: const BoxDecoration(
                color: complementaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            width: Get.size.width - 40,
            height: 50,
            alignment: Alignment.center,
            child: const Text(
              '시작하기',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ]);
  }

  // static RectTween _createRectTween(Rect? begin, Rect? end) {
  //   return CustomRectTween(a: begin, b: end);
  // }
}

// class CustomRectTween extends RectTween {
//   CustomRectTween({this.a, this.b}) : super(begin: a, end: b);
//   final Rect? a;
//   final Rect? b;

//   @override
//   Rect lerp(double t) {
//     Curves.elasticOut.transform(t);
//     //http://www.roblaplaca.com/examples/bezierBuilder/
//     final verticalDist = const Cubic(1, 0, 1, 0).transform(t);

//     final top = lerpDouble(a?.top, b?.top, t) * (1 - verticalDist);
//     return Rect.fromLTRB(
//       lerpDouble(a?.left, b?.left, t),
//       top,
//       lerpDouble(a?.right, b?.right, t),
//       lerpDouble(a?.bottom, b?.bottom, t),
//     );
//   }

//   double lerpDouble(num? a, num? b, double t) {
//     if (a == null && b == null) return 0.0;
//     a ??= 0.0;
//     b ??= 0.0;
//     return a + (b - a) * t;
//   }
// }
