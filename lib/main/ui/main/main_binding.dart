import 'package:bitel_ventas/main/ui/main/main_logic.dart';
import 'package:get/get.dart';

class MainBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MainLogic>(() => MainLogic());
  }
}