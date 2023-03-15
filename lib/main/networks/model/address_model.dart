class AddressModel{
  String? _areaCode;
  String? _name;
  String? _province;
  String? _district;
  String? _precinct;


  AddressModel();
  AddressModel.fromJson(Map<String, dynamic> json) {
    _areaCode = json['areaCode'];
    _name = json['name'];
    _province = json['province'];
    _district = json['district'];
    _precinct = json['precinct'];
  }


  String get name => _name ?? "";

  set name(String value) {
    _name = value;
  }

  String get areaCode => _areaCode ?? "";

  set areaCode(String value) {
    _areaCode = value;
  }

  String get precinct => _precinct ?? "";

  String get district => _district ?? "";

  String get province => _province ?? "";
}