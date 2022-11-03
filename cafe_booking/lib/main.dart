import 'package:cafe_booking/app/core/values/firebase_api.dart';
import 'package:cafe_booking/app/data/hive_enum.dart';
import 'package:cafe_booking/app/data/services/firebase_controller.dart';
import 'package:cafe_booking/app/modules/login/controller/login_controller.dart';
import 'package:cafe_booking/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'app/modules/dashboard/views/dashboard_main_page.dart';
import 'app/modules/login/views/intro.dart';

Future main() async {
  await Hive.initFlutter();

  await Hive.openBox(LoginHiveEnum.openBox.openBoxName);
  // WidgetsFlutterBinding.ensureInitialized();
  Get.put(FCMController(), permanent: true);
  //For Kakao oauth
  KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      home: const MyAppStateful(),
      initialRoute: '/',
      initialBinding: BindingsBuilder(() {
        Get.put<LoginController>(LoginController(), permanent: true);
      }),
    );
  }
}

class MyAppStateful extends StatefulWidget {
  const MyAppStateful({Key? key}) : super(key: key);

  @override
  State<MyAppStateful> createState() => _MyAppStatefulState();
}

class _MyAppStatefulState extends State<MyAppStateful> {
  @override
  Widget build(BuildContext context) {
    // return IntroPage();
    return Obx(() => LoginController.to.isConfirmLogin ? MainDashboard() : IntroPage());
  }
}
