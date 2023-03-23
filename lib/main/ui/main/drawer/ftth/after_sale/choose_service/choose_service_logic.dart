import 'package:get/get.dart';

class ChooseServiceLogic extends GetxController{
  bool isActive = true;
  var valueService = (-1).obs;
  void setActive(bool value) {
    isActive = value;
    update();
  }
}