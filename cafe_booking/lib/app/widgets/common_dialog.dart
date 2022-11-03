import 'package:cafe_booking/app/widgets/rives/coffee_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDialog {
  ///로딩화면
  ///기본적으로 다이얼로그 외곽클릭해도 꺼지지 않게 되어있음.
  ///[barrierDismissable]로 조절가능
  ///[callback]사용가능.
  static loadingDialog({
    VoidCallback? callback,
    double? height,
    double? width,
    bool barrierDismissable = false,
  }) {
    callback ??= () {};

    return showDialog(
        context: Get.context as BuildContext,
        // barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
              onWillPop: () async => Future(() => barrierDismissable),
              child: const Dialog(
                backgroundColor: Colors.transparent,
                insetAnimationCurve: Curves.ease, insetPadding: EdgeInsets.all(70),
                // shape: RoundedRectangleBorder(),
                elevation: 0.0,

                child: AspectRatio(aspectRatio: 1.0, child: CoffeeLoading()),
              ),
            )).then((value) => callback!());
  }
}
