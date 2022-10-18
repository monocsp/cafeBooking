import 'package:cafe_booking/screens/login/views/login_main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: '/LoginMainPage', page: () => LoginMainPage()),
  ];
}
