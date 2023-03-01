class CustomerModel{
  String? _firstName;
  String? _fullName;
  String? _lastName;
  String? phone;
  String? type;
  String? idNumber;

  CustomerModel();
  CustomerModel.fromJson(Map<String, dynamic> json) {
    _firstName = json['firstName'];
    _fullName = json['fullName'];
    _lastName = json['lastName'];
    phone = json['phone'];
    type = json['type'];
    idNumber = json['idNumber'];
  }

  String get fullName => _fullName ?? "";

  set fullName(String value) {
    _fullName = value;
  }
}