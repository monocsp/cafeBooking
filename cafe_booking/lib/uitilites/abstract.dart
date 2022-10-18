import 'package:get/get.dart';

abstract class CustomGetxController extends GetxController {
  RxBool fetchStatus = false.obs;
  RxBool errorStatus = false.obs;
}
