import 'package:get/get.dart';

class DialogSurveySuccessfulLogic extends GetxController{
  bool isSelectOffline = false;

  void setSurveyOffline(bool value){
    isSelectOffline = value;
    update();
  }
}