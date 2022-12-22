import 'package:get/get.dart';

import '../../login/login_page.dart';

class DrawerLogic extends GetxController{
  void logOut() {
    Get.offAll(LoginPage());
  }
}