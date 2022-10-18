import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();
  RxInt isSelected = (-1).obs;
}
