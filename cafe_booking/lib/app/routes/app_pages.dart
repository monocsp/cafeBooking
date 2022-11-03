import 'package:get/get.dart';
import '../modules/login/views/login_main_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: '/LoginMainPage', page: () => LoginMainPage()),
  ];
}
