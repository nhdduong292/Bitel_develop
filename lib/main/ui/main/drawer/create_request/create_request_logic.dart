import 'package:get/get.dart';

class CreateRequestLogic extends GetxController{
    String currentService = "";
    List<String> listService =["FTTH", "Mobile", "Network"];
    String currentIdentity = "DNI";
    List<String> listIdentity = ["DNI", "DSA"];
    String currentProvince = "HN";
    List<String> listProvince = ["HN", "HCM", "Hue"];
    String currentDistrict = "VN";
    List<String> listDistrict = ["VN", "TQ","LAO"];
    String currentPrecinct = "";
    List<String> listPrecinct = ["1","2","3"];
    String currentAddress = "";
    List<String> listAddress = ["TDP", "Xa", "Phuong"];
}