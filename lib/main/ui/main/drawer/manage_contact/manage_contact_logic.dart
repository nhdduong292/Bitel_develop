import 'package:get/get.dart';

class ManageContactLogic extends GetxController {
  RxString dni = "DNI".obs;
  List<String> identifyNumberType = ['DNI', 'DIN1', 'DNI2'];

  List<Contact> listContact = [
    Contact(
        name: 'Nguyen Van A', dob: '1/1/1999', type: 'DNI', idNumber: '123456'),
    Contact(
        name: 'Nguyen Van B', dob: '1/1/1999', type: 'DNI', idNumber: '456789')
  ];
}

class Contact {
  String name;
  String dob;
  String type;
  String idNumber;

  Contact({
    required this.name,
    required this.dob,
    required this.type,
    required this.idNumber,
  });
}