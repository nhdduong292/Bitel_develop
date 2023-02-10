import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:get/get.dart';

class CreateRequestLogic extends GetxController{
    String currentService = "FTTH";
    List<String> listService =["FTTH", "Office Wan", "Leased Line"];
    String currentIdentity = "DNI";
    List<String> listIdentity = ["DNI", "CE", "PP", "PTP"];
    String currentProvince = "HN";
    List<String> listProvince = ["HN", "HCM", "Hue"];
    String currentDistrict = "VN";
    List<String> listDistrict = ["VN", "TQ","LAO"];
    String currentPrecinct = "";
    List<String> listPrecinct = ["1","2","3"];
    String currentAddress = "";
    List<String> listAddress = ["TDP", "Xa", "Phuong"];

    void createRequest() async{
        Map<String, dynamic> body = {
            "address": "proid",
            "district": "irure magna in",
            "idNumber": "1234564",
            "name": "amet",
            "phone": "097845535634563",
            "precinct": "nisi",
            "province": "ea est magna esse ut",
            "service": "FTTH",
            "identityType": "PTP"
        };
        ApiUtil.getInstance()!.post(
            url: "http://10.121.14.196:9092/v1/requests",
            body: body,
            onSuccess: (response) {
              if(response.isSuccess){
                  print("success");
              } else {
                  print("error: ${response.status}");
              }
            },
            onError: (error) {
                print("error: " + error.toString());
            });
    }
}