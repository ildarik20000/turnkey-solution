import 'package:get/get.dart';

class Controller extends GetxController {
  RxBool isLoggedIn = false.obs;
  void loginIn() {
    isLoggedIn = RxBool(true);
    update();
  }

  void loginOut() {
    isLoggedIn = RxBool(false);
    update();
  }
}
