import 'package:get/get.dart';

class DialogSurveyUnsuccessfullLogic extends GetxController{
  bool isSelectOffline = true;

  void setSurveyOffline(bool value){
    isSelectOffline = value;
    update();
  }
}