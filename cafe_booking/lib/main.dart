import 'package:cafe_booking/data/hive_enum.dart';
import 'package:cafe_booking/data/services/firebase_controller.dart';

import 'package:cafe_booking/screens/login/controller/login_controller.dart';
import 'package:cafe_booking/screens/login/views/intro.dart';

import 'package:cafe_booking/screens/routes/app_pages.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'screens/dashboard/views/dashboard_main_page.dart';

Future main() async {
  await Hive.initFlutter();

  await Hive.openBox(LoginHiveEnum.openBox.openBoxName);
  // WidgetsFlutterBinding.ensureInitialized();
  Get.put(FCMController(), permanent: true);

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
    return Obx(() =>
        LoginController.to.isConfirmLogin ? MainDashboard() : IntroPage());
  }
}
