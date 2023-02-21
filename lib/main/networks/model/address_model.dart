class AddressModel{
  String? areaCode;
  String? name;

  AddressModel();
  AddressModel.fromJson(Map<String, dynamic> json) {
    areaCode = json['areaCode'];
    name = json['name'];
  }
}