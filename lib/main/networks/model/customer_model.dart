class CustomerModel{
  String? firstName;
  String? lastName;
  String? phone;
  String? type;
  String? idNumber;

  CustomerModel();
  CustomerModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    type = json['type'];
    idNumber = json['idNumber'];
  }
}