class AddressModel{
  String? _areaCode;
  String? _name;

  AddressModel();
  AddressModel.fromJson(Map<String, dynamic> json) {
    _areaCode = json['areaCode'];
    _name = json['name'];
  }

  String get name => _name ?? "";

  set name(String value) {
    _name = value;
  }

  String get areaCode => _areaCode ?? "";

  set areaCode(String value) {
    _areaCode = value;
  }
}