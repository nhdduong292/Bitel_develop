import 'package:get/get.dart';

class DialogSurveyUnsuccessfullLogic extends GetxController{
  bool isSelectOffline = false;

  void setSurveyOffline(bool value){
    isSelectOffline = value;
    update();
  }
}